//
//  CategoryInputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/11.
//

import SwiftUI
import UIKit

struct CategoryInputView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = CategoryViewModel.shared
    
    // MARK: - Receive
    public var category: Category? = nil
    
    // MARK: - Input
    @State private var name = ""
    @State private var selectColor: AppThemaColor = .red
    
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
                    // キーボードを閉じる
                    UIApplication.shared.closeKeyboard()
                    
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
            
            SectionTitleView(title: "Category Name")
            InputView(placeholder: L10n.categoryInputPlaceholder, value: $name)
            
            
            HStack(spacing: 15) {
                ForEach(AppThemaColor.allCases, id: \.self) { color in
                    Button {
                        selectColor = color
                    } label: {
                        AppThemaColor.getColor(color.rawValue)
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
            
            AdMobBannerView()
                .frame(height: 60)
            
        }.background(Color.exThema)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
            .dialog(
                isPresented: $showSuccessDialog,
                title: L10n.dialogTitle,
                message: category == nil ? L10n.dialogEntryCategory(name.limitLength) : L10n.dialogUpdateCategory(name.limitLength),
                positiveButtonTitle: L10n.dialogButtonOk,
                negativeButtonTitle: "",
                positiveAction: { dismiss() },
                negativeAction: {}
            )
            .dialog(
                isPresented: $showFailedDialog,
                title: L10n.dialogTitle,
                message:  L10n.dialogValidationCategory,
                positiveButtonTitle:  L10n.dialogButtonOk,
                negativeButtonTitle: "",
                positiveAction: { showFailedDialog = false},
                negativeAction: {}
            ).onAppear {
                if let category = category {
                    name = category.wrappedName
                    selectColor = AppThemaColor(rawValue: category.wrappedColor) ?? .red
                }
            }
    }
}

//#Preview {
//    CategoryInputView()
//}
