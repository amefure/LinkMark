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
    }
}

#Preview {
    RootView()
}
