//
//  CategoryInputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/11.
//

import SwiftUI

struct CategoryInputView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = CategoryViewModel.shared
    
    // MARK: - Receive
    public var category: Category? = nil
    
    // MARK: - Input
    @State private var name = ""
    @State private var selectColor: CategoryColor = .red
    
    // MARK: - View
    @State private var showFailedDialog = false
    @State private var showSuccessDialog = false
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(
                leadingIcon: "arrow.backward",
                trailingIcon: "checkmark",
                leadingAction: { dismiss() },
                trailingAction: {
                    guard !name.isEmpty else {
                        showFailedDialog = true
                        return
                    }
                    
                    if let category = category {
                        // 新規
                        viewModel.updateCategory(id: category.wrappedId, name: name, color: selectColor.rawValue)
                    } else {
                        // 新規
                        viewModel.addCategory(name: name, color: selectColor.rawValue)
                    }
                    showSuccessDialog = true
                }
            )
            
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
            
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
            .dialog(
                isPresented: $showSuccessDialog,
                title: "お知らせ",
                message: category == nil ? "カテゴリ「\(name.limitLength)」を\n登録しました。" : "カテゴリ「\(name.limitLength)」を\n更新しました。",
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
            ).onAppear {
                if let category = category {
                    name = category.wrappedName
                    selectColor = CategoryColor(rawValue: category.wrappedColor) ?? .red
                }
            }
    }
}

//#Preview {
//    CategoryInputView()
//}
