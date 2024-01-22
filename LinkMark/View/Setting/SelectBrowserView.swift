//
//  SelectBrowserView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/22.
//

import SwiftUI

struct SelectBrowserView: View {
    
    // MARK: - Environment
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    
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
                    rootEnvironment.setSelectBrowser(browser: browser)
                    rootEnvironment.changeSelectBrowser(browser: browser)
                } label: {
                    HStack {
                        Text(browser.rawValue)
                        
                        Spacer()
                        
                        if rootEnvironment.selectBrowser == browser {
                            rootEnvironment.appColor
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }.foregroundStyle(.exText)
            }
        }.background(.exThema)
    }
}

#Preview {
    SelectBrowserView()
}
