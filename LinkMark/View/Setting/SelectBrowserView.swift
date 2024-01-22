//
//  SelectBrowserView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/22.
//

import SwiftUI

struct SelectBrowserView: View {
    
    @StateObject private var viewModel = SettingViewModel()
    @State private var selectBrowser: BrowserConfig = .safari
    
    var body: some View {
        VStack {
            Spacer()

            Text("Browser")
                .fontWeight(.bold)
                .foregroundStyle(.exText)
                .padding(.top, 70)
            
            Text("選択したブラウザでURLを開くことができます。")
                .foregroundStyle(.exText)
                .padding(.top, 10)
                .font(.caption)
            
            List(BrowserConfig.allCases, id: \.self) { browser in
                Button {
                    selectBrowser = browser
                    viewModel.setSelectBrowser(browser: browser)
                } label: {
                    HStack {
                        Text(browser.rawValue)
                        
                        Spacer()
                        
                        if selectBrowser == browser {
                            Color.exRed
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }.foregroundStyle(.exText)
            }
        }.background(.exThema)
            .onAppear {
                selectBrowser = viewModel.getSelectBrowser()
            }
    }
}

#Preview {
    SelectBrowserView()
}
