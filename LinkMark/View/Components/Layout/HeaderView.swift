//
//  HeaderView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

//
//  HeaderView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - Receive
    public var leadingIcon: String = ""
    public var trailingIcon: String  = ""
    public var leadingAction: () -> Void = {}
    public var trailingAction: () -> Void = {}
    public var isShowLogo: Bool = true
    
    var body: some View {
        HStack {
            
            if !leadingIcon.isEmpty {
                
                Button {
                    leadingAction()
                } label: {
                    Image(systemName: leadingIcon)
                        .font(.system(size: 18))
                }.padding(.leading, 5)
                    .frame(width: 50)
            } else if !trailingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
            
            Spacer()
            
            if isShowLogo {
                Text("LINKMARK")
                    .fontWeight(.bold)
                    .font(.system(size: 18).monospaced())
                    .opacity(0.8)
            }
            
            Spacer()

            if !trailingIcon.isEmpty {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: trailingIcon)
                        .font(.system(size: 18))
                }.padding(.trailing, 5)
                    .frame(width: 50)
            } else if !leadingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
        }.foregroundStyle(.exText)
            .padding(8)
    }
}

#Preview {
    HeaderView(leadingIcon: "swift", trailingIcon: "iphone", leadingAction: {}, trailingAction: {})
}
