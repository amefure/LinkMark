//
//  RootView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            CategoryListView()
        }.background(Color.exThema)
            .navigationDestination(for: ScreenPath.self) { value in
                // WebViewへのトグル形式の設計だとフリーズするため(インスタンスが複数生成されるため)
                // navigationDestination(for: )で遷移させる
                switch value {
                case .webView(let url):
                    ControlWebView(url: url)
                case .locatorList(let category):
                    LocatorListView(category: category)
                }
            }
    }
}

#Preview {
    RootView()
}
