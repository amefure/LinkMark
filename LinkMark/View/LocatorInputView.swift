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
    
    @State private var title = ""
    @State private var url = ""
    @State private var memo = ""
    
    @State private var showValidationEmptyFlag = false
    @State private var showValidationUrlFlag = false
    @State private var showSuccessDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    func validationUrl(url: String) -> Bool {
        guard let nsurl = NSURL(string: url) else {
            return false
        }
        guard UIApplication.shared.canOpenURL(nsurl as URL) else {
           return false
       }
        return true
    }
    
    
    var body: some View {
        
        VStack {
            Text("LINKMARK")
            
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
            
            InputView(placeholder: "例：https://XXX.com/", value: $url)
            
            SectionTitleView(title: "MEMO")
            InputView(placeholder: "", value: $memo)
            
            Spacer()
            
            Button {
                if title.isEmpty {
                    showValidationEmptyFlag = true
                }
                if !validationUrl(url: url) {
                    showValidationUrlFlag = true
                }
                
                guard !showValidationEmptyFlag && !showValidationUrlFlag  else { return }
                
                viewModel.addLocator(categoryId: category.wrappedId, title: title, url: URL(string: "https://tech.amefure.com/")!, memo: memo)
                
                showSuccessDialog = true
            } label: {
                Text("登録")
            }
            
            
        }.background(Color.exThema)
            .dialog(
                isPresented: $showSuccessDialog,
                title: "お知らせ",
                message: "リンク「\(title)」を\n登録しました。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "",
                positiveAction: { dismiss() },
                negativeAction: {}
            )
    }
}

//#Preview {
//    LocatorInputView(category: <#T##Category#>)
//}
