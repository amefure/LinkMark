//
//  SectionTitleView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import SwiftUI

struct SectionTitleView: View {
    public var title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.exText)
                .opacity(0.5)
                .padding(.leading, 20)
            
            Spacer()
        }
       
    }
}

#Preview {
    SectionTitleView(title: "Test")
}
