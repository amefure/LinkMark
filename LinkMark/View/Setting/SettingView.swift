//
//  SettingView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/20.
//

import SwiftUI

// MARK: - 設定ビュー
struct SettingView: View {
    // MARK: - ViewModel

    @StateObject private var viewModel = SettingViewModel()

    // MARK: - View

    @State private var isLock: Bool = false
    @State private var isDaysLaterFlag: Bool = false
    @State private var isAgeMonthFlag: Bool = false
    @State private var show: Bool = false
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - ViewComponent

            HeaderView(leadingIcon: "arrow.backward", leadingAction: {
                dismiss()
            })

            // List ここから
            List {
                // MARK: - (1)

                Section(header: Text(L10n.settingSectionAppTitle),
                        footer: Text(L10n.settingSectionAppDesc))
                {
                    
                    HStack {
                        Image(systemName: "network")
                            
                        Button {
                            show = true
                        } label: {
                            Text(L10n.settingSectionAppBrowser)
                        }
                        
                        Spacer()
                        
                        Text(viewModel.getSelectBrowser().rawValue)
                        
                    }.sheet(isPresented: $show, content: {
                        SelectBrowserView()
                    })
                    .foregroundStyle(.white)

                    HStack {
                        Image(systemName: "lock.iphone")
                            
                        Toggle(isOn: $isLock) {
                            Text(L10n.settingSectionAppLock)
                        }.onChange(of: isLock, perform: { newValue in
                            if newValue {
                                viewModel.showPassInput()
                            } else {
                                viewModel.deletePassword()
                            }
                        }).tint(.exPositive)
                    }.sheet(isPresented: $viewModel.isShowPassInput, content: {
                        AppLockInputView(isLock: $isLock)
                    })
                    .foregroundStyle(.white)
                }.listRowBackground(Color.exRed)

                // MARK: - (2)


                Section(header: Text("Link"), footer: Text(L10n.settingSectionLinkDesc)) {
//                    if let url = URL(string: UrlLinkConfig.APP_REVIEW_URL) {
//                        // 1:レビューページ
//                        Link(destination: url, label: {
//                            HStack {
//                                Image(systemName: "hand.thumbsup")
//                                Text(L10n.settingSectionLinkReview)
//                            }
//                        }).listRowBackground(Color.exRed)
//                            .foregroundStyle(.white)
//                    }

                    // 2:シェアボタン
//                    Button(action: {
//                        viewModel.shareApp(
//                            shareText: "",
//                            shareLink: ""
//                        )
//                    }) {
//                        HStack {
//                            Image(systemName: "star.bubble")
//                                
//                            Text(L10n.settingSectionLinkRecommend)
//                        }
//                    }.listRowBackground(Color.exRed)
//                        .foregroundStyle(.white)

                    if let url = URL(string: UrlLinkConfig.APP_CONTACT_URL) {
                        // 3:お問い合わせフォーム
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "paperplane")
                                Text(L10n.settingSectionLinkContact)
                                Image(systemName: "link").font(.caption)
                            }
                        }).listRowBackground(Color.exRed)
                            .foregroundStyle(.white)
                    }

                    if let url = URL(string: UrlLinkConfig.APP_TERMS_OF_SERVICE_URL) {
                        // 4:利用規約とプライバシーポリシー
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "note.text")
                                Text(L10n.settingSectionLinkTerms)
                                Image(systemName: "link").font(.caption)
                            }
                        }).listRowBackground(Color.exRed)
                            .foregroundStyle(.white)
                    }
                }

            }.listStyle(GroupedListStyle())
                .scrollContentBackground(.hidden)
                .background(.exThema)
                .foregroundColor(.exText)
            // List ここまで

            Spacer()

            AdMobBannerView()
                .frame(height: 50)
        }
        .onAppear {
            isLock = viewModel.isLock
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .background(.exThema)
    }
}


#Preview {
    SettingView()
}
