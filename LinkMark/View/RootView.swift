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
