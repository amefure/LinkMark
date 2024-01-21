//
//  FoundationImageView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/21.
//

import SwiftUI

struct FoundationImageView: View {
    
    public var title: String
    public var msg: String
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(title)
                .font(.title)
                .opacity(0.7)
            
            Spacer()
            
            Text(msg)
            
            Spacer()
            
            Asset.Images.unavailable.swiftUIImage
                .resizable()
                .frame(width: 300, height: 300)
            
            Spacer()
        }.foregroundStyle(.exText)
    }
}

#Preview {
    FoundationImageView(title: "NETWORK ERROR", msg: L10n.webviewNetworkUnavailable)
}
