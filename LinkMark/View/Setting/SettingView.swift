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

                Section(header: Text("アプリ設定"),
                        footer: Text("・アプリにパスワードを設定してロックをかけることができます。"))
                {

                    HStack {
                        Image(systemName: "lock.iphone")
                            
                        Toggle(isOn: $isLock) {
                            Text("アプリをロックする")
                        }.onChange(of: isLock, perform: { newValue in
                            if newValue {
                                viewModel.showPassInput()
                            } else {
                                viewModel.deletePassword()
                            }
                        }).tint(.exBlue)
                    }.sheet(isPresented: $viewModel.isShowPassInput, content: {
                        AppLockInputView(isLock: $isLock)
                    })
                    .foregroundStyle(.white)
                }.listRowBackground(Color.exRed)

                // MARK: - (3)

//                Section(header: Text("広告"),
//                        footer: Text("・追加される容量は\(AdsConfig.ADD_CAPACITY)個です。\n・容量の追加は1日に1回までです。"))
//                {
//                    RewardButtonView(viewModel: viewModel)
//                    HStack {
//                        Image(systemName: "bag")
//                        Text("現在の容量:\(viewModel.getCapacity())人")
//                    }
//                }.listRowBackground(.exLightGray)

                // MARK: - (4)

                Section(header: Text("Link"), footer: Text("・アプリに不具合がございましたら「アプリの不具合はこちら」よりお問い合わせください。")) {
                    if let url = URL(string: "https://apps.apple.com/jp/app/%E3%81%BF%E3%82%93%E3%81%AA%E3%81%AE%E8%AA%95%E7%94%9F%E6%97%A5/id1673431227?action=write-review") {
                        // 1:レビューページ
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                Text("アプリをレビューする")
                            }
                        }).listRowBackground(Color.exRed)
                            .foregroundStyle(.white)
                    }

                    // 2:シェアボタン
                    Button(action: {
                        viewModel.shareApp(
                            shareText: "",
                            shareLink: ""
                        )
                    }) {
                        HStack {
                            Image(systemName: "star.bubble")
                                
                            Text("「LINKMARK」をオススメする")
                        }
                    }.listRowBackground(Color.exRed)
                        .foregroundStyle(.white)

                    if let url = URL(string: "https://tech.amefure.com/contact") {
                        // 3:お問い合わせフォーム
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "paperplane")
                                Text("アプリの不具合はこちら")
                                Image(systemName: "link").font(.caption)
                            }
                        }).listRowBackground(Color.exRed)
                            .foregroundStyle(.white)
                    }

                    if let url = URL(string: "https://tech.amefure.com/app-terms-of-service") {
                        // 4:利用規約とプライバシーポリシー
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "note.text")
                                Text("利用規約とプライバシーポリシー")
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

//            AdMobBannerView().frame(height: 50)
        }
        .onAppear {
            viewModel.onAppear()
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
