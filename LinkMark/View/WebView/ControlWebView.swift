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
    private let uICustomWebView: UICustomWebView!
    
    init(url: URL) {
        self.url = url
        uICustomWebView = UICustomWebView(url: url)
    }
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HeaderView(leadingIcon: "arrow.backward", leadingAction: {
                dismiss()
            })
            
            uICustomWebView
            
            HStack(spacing: 0) {
                Button {
                    uICustomWebView.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18))
                }.frame(width: 40)
                
                Button {
                    uICustomWebView.goForward()
                } label: {
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 18))
                }.frame(width: 40)
                
                Spacer()
                
                Button {
                    uICustomWebView.reload()
                } label: {
                    Image(systemName: "goforward")
                        .font(.system(size: 18))
                }.frame(width: 40)
            }.foregroundStyle(.exText)
                .padding(10)
                .padding(.horizontal)
                
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    ControlWebView(url: URL(string: "https://tech.amefure.com/")!)
}
