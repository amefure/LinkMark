//
//  LocatorInput.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import SwiftUI

struct LocatorInputView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel.shered
    
    public var category: Category
    
    @State private var title = ""
    @State private var url = ""
    @State private var memo = ""
    
    @State private var showFailedDialog = false
    @State private var showSuccessDialog = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack {
            Text("LINKMARK")
            
            SectionTitleView(title: "タイトル")
            InputView(placeholder: "例：レシピ・趣味など", value: $title)
            
            SectionTitleView(title: "URL")
            InputView(placeholder: "例：https://XXX.com/", value: $url)
            
            SectionTitleView(title: "MEMO")
            InputView(placeholder: "", value: $memo)
            
            Button {
                guard !title.isEmpty else {
                    showFailedDialog = true
                    return
                }
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
            .dialog(
                isPresented: $showFailedDialog,
                title: "お知らせ",
                message: "タイトルは必須入力です。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "",
                positiveAction: { showFailedDialog = false},
                negativeAction: {}
            )
    }
}

//#Preview {
//    LocatorInputView(category: <#T##Category#>)
//}
