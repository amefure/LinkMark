//
//  CategoryInputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/11.
//

import SwiftUI

struct CategoryInputView: View {
    
    @ObservedObject private var viewModel = CategoryViewModel.shared
    
    @State private var name = ""
    @State private var selectColor: CategoryColor = .red
    
    @State private var showFailedDialog = false
    @State private var showSuccessDialog = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            Text("LINKMARK")
            
            SectionTitleView(title: "カテゴリ名")
            InputView(placeholder: "例：レシピ・趣味など", value: $name)
            
            
            HStack(spacing: 15) {
                ForEach(CategoryColor.allCases, id: \.self) { color in
                    Button {
                        selectColor = color
                    } label: {
                        CategoryColor.getColor(color.rawValue)
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(selectColor == color ? Color.exLightGray : .clear, lineWidth: 4)
                            }
                    }
                }
            }.padding(.vertical)
            
            Spacer()
            
            
            Button {
                guard !name.isEmpty else {
                    showFailedDialog = true
                    return
                }
                viewModel.addCategory(name: name, color: selectColor.rawValue)
                
                showSuccessDialog = true
            } label: {
                Text("登録")
            }
            
            Spacer()
            
        }.background(Color.exThema)
            .dialog(
                isPresented: $showSuccessDialog,
                title: "お知らせ",
                message: "カテゴリ「\(name.limitLength)」を\n登録しました。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "",
                positiveAction: { dismiss() },
                negativeAction: {}
            )
            .dialog(
                isPresented: $showFailedDialog,
                title: "お知らせ",
                message: "カテゴリ名は必須入力です。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "",
                positiveAction: { showFailedDialog = false},
                negativeAction: {}
            )
    }
}

#Preview {
    CategoryInputView()
}
