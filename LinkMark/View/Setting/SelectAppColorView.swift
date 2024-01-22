//
//  SelectAppColorView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/22.
//

import SwiftUI

struct SelectAppColorView: View {
    
    // MARK: - Environment
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    
    // MARK: - Size & Padding
    /// カテゴリ行の右カラーアイコンサイズ
    private var categoryRowColorSize: CGFloat {
        if DeviceSizeManager.isSESize {
            return 25
        } else {
            return 40
        }
    }
    
    var body: some View {
        VStack {
            Spacer()

            Text("ThemaColor")
                .fontWeight(.bold)
                .foregroundStyle(.exText)
                .padding(.top, 70)
            
            Text(L10n.selectColorText)
                .foregroundStyle(.exText)
                .padding(.top, 10)
                .font(.caption)
            
            List(AppThemaColor.allCases, id: \.self) { color in
                Button {
                    rootEnvironment.setAppColor(color: color)
                } label: {
                    HStack {
                        
                        AppThemaColor.getColor(color.rawValue)
                            .frame(width: categoryRowColorSize, height: categoryRowColorSize)
                            .clipShape(RoundedRectangle(cornerRadius: categoryRowColorSize))
                       
                        Text(color.name)
                        
                        Spacer()
                        
                        if rootEnvironment.appColor == color {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.exText)
                        }
                    }
                }.foregroundStyle(.exText)
            }
        }.background(.exThema)
    }
}

#Preview {
    SelectAppColorView()
}
