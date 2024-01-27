//
//  LocatorInput.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import SwiftUI

struct LocatorInputView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = LocatorViewModel.shared
    
    // MARK: - Receive
    public var category: Category
    public var locator: Locator? = nil
    
    // MARK: - Input
    @State private var title = ""
    @State private var urlStr = ""
    @State private var memo = ""
    
    // MARK: - View
    @State private var showValidationEmptyFlag = false
    @State private var showValidationUrlFlag = false
    @State private var showSuccessDialog = false
    @State private var showFailedDialog = false
    @State private var showFailedGetTitleDialog = false
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    /// URLのバリデーション&キャスト
    private func validationGetUrl(url: String) -> URL? {
        guard let nsurl = NSURL(string: url) else {
            return nil
        }
        guard UIApplication.shared.canOpenURL(nsurl as URL) else {
           return nil
       }
        return nsurl as URL
    }
    
    /// 登録時バリデーションメッセージ
    private var failedDialogMessage: String {
        var msg = ""
        if showValidationEmptyFlag {
            msg = L10n.locatorInputValidationTitle
        }
        if showValidationUrlFlag {
            if showValidationEmptyFlag {
                msg += "\n"
            }
            msg += L10n.locatorInputValidationUrl
        }
        return msg
    }
    
    
    var body: some View {
        
        VStack {
            HeaderView(
                leadingIcon: "arrow.backward",
                trailingIcon: "checkmark",
                leadingAction: { dismiss() },
                trailingAction: {
                    // キーボードを閉じる
                    UIApplication.shared.closeKeyboard()
                    
                    showValidationEmptyFlag = false
                    showValidationUrlFlag = false
                    if title.isEmpty {
                        showValidationEmptyFlag = true
                    }
                    
                    guard let url = validationGetUrl(url: urlStr) else {
                        showValidationUrlFlag = true
                        showFailedDialog = true
                        return
                    }
                    
                    guard !showValidationEmptyFlag || !showValidationUrlFlag else {
                        showFailedDialog = true
                        return
                    }
                    
                    
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
                SectionTitleView(title: "Title")
                
                HStack {
                    Spacer()
                    Button {
                        Task {
                            showValidationUrlFlag = false
                            guard let url = validationGetUrl(url: urlStr) else {
                                showValidationUrlFlag = true
                                showFailedDialog = true
                                return
                            }
                            do {
                                title = try await URL.fetchMetadataTitle(url: url)
                                if title.isEmpty {
                                    showFailedGetTitleDialog = true
                                }
                            } catch {
                                showFailedGetTitleDialog = true
                            }
                        }
                    } label: {
                        Text(L10n.locatorInputGetTitleButton)
                            .foregroundStyle(.white)
                            .frame(width: 130, height: 30)
                            .background(AppThemaColor.getColor(category.wrappedColor))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .exText, radius: 2, x: 1, y: 1)
                    }.padding(.trailing)
                }
            }
           
            InputView(placeholder: L10n.locatorInputPlaceholderTitle, value: $title)
            
            SectionTitleView(title: "Link")
            
            InputView(placeholder: L10n.locatorInputPlaceholderUrl, value: $urlStr)
            
            SectionTitleView(title: "MEMO")
            InputView(placeholder: "", value: $memo)
            
            Spacer()
            
            AdMobBannerView()
                .frame(height: 60)
            
        }.background(Color.exThema)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
            .dialog(
                isPresented: $showSuccessDialog,
                title: L10n.dialogTitle,
                message: locator == nil ? L10n.dialogEntryLocator(title.limitLength) : L10n.dialogUpdateLocator(title.limitLength),
                positiveButtonTitle: L10n.dialogButtonOk,
                negativeButtonTitle: "",
                positiveAction: { dismiss() },
                negativeAction: {}
            ).dialog(
                isPresented: $showFailedDialog,
                title: L10n.dialogTitle,
                message: failedDialogMessage,
                positiveButtonTitle:  L10n.dialogButtonOk,
                negativeButtonTitle: "",
                positiveAction: { showFailedDialog = false},
                negativeAction: {}
            ).dialog(
                isPresented: $showFailedGetTitleDialog,
                title: L10n.dialogTitle,
                message: L10n.locatorInputFailedGetTitleMsg,
                positiveButtonTitle:  L10n.dialogButtonOk,
                negativeButtonTitle: "",
                positiveAction: { showFailedGetTitleDialog = false},
                negativeAction: {}
            )
            .onAppear {
                if let locator = locator {
                    title = locator.wrappedTitle
                    urlStr = locator.url?.absoluteString ?? ""
                    memo = locator.wrappedMemo
                }
            }
    }
}

#Preview {
    LocatorInputView(category: Category.demoCategorys.first!)
}
