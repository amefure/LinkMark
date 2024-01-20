//
//  LocatorInput.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import SwiftUI

struct LocatorInputView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel.shared
    
    public var category: Category
    
    public var locator: Locator? = nil
    
    @State private var title = ""
    @State private var urlStr = ""
    @State private var memo = ""
    
    @State private var showValidationEmptyFlag = false
    @State private var showValidationUrlFlag = false
    @State private var showSuccessDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    func validationGetUrl(url: String) -> URL? {
        guard let nsurl = NSURL(string: url) else {
            return nil
        }
        guard UIApplication.shared.canOpenURL(nsurl as URL) else {
           return nil
       }
        return nsurl as URL
    }
    
    
    var body: some View {
        
        VStack {
            HeaderView(
                leadingIcon: "arrow.backward",
                trailingIcon: "checkmark",
                leadingAction: { dismiss() },
                trailingAction: {
                    showValidationEmptyFlag = false
                    showValidationUrlFlag = false
                    if title.isEmpty {
                        showValidationEmptyFlag = true
                    }
            
                    guard let url = validationGetUrl(url: urlStr) else {
                        showValidationUrlFlag = true
                        return
                    }
                    
                    guard !showValidationEmptyFlag && !showValidationUrlFlag  else { return }
                    
                    
                    if let locator = locator {
                        // 更新
                        viewModel.updateLocator(id: locator.wrappedId, title: title, url: url, memo: memo)
                    } else {
                        // 登録
                        viewModel.addLocator(categoryId: category.wrappedId, title: title, url: url, memo: memo)
                    }
                    
                    
                    showSuccessDialog = true
                }
            )
            
            ZStack {
                SectionTitleView(title: "タイトル")
                if showValidationEmptyFlag {
                    Text("・タイトルは必須入力です。")
                        .foregroundStyle(.red)
                }
                
            }
           
            InputView(placeholder: "例：レシピ・趣味など", value: $title)
            
            ZStack {
                SectionTitleView(title: "Link")
                if showValidationUrlFlag {
                    Text("・有効なリンクを入力してください。")
                        .foregroundStyle(.red)
                }
               
            }
            
            InputView(placeholder: "例：https://XXX.com/", value: $urlStr)
            
            SectionTitleView(title: "MEMO")
            InputView(placeholder: "", value: $memo)
            
            Spacer()
            
            
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
            .dialog(
                isPresented: $showSuccessDialog,
                title: "お知らせ",
                message: locator == nil ? "リンク「\(title)」を\n登録しました。" : "リンク「\(title)」を\n更新しました。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "",
                positiveAction: { dismiss() },
                negativeAction: {}
            ).onAppear {
                if let locator = locator {
                    title = locator.wrappedTitle
                    urlStr = locator.url?.absoluteString ?? ""
                    memo = locator.wrappedMemo
                }
            }
    }
}

//#Preview {
//    LocatorInputView(category: <#T##Category#>)
//}
