//
//  ControlWebView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import SwiftUI

// Swift UIでWebViewを操作するための枠View
struct ControlWebView: View {
    public var url: URL
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HeaderView(leadingIcon: "arrow.backward", leadingAction: {
                dismiss()
            })
            UICustomWebView(url: url)
                
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    ControlWebView(url: URL(string: "https://tech.amefure.com/")!)
}
