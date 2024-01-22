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

            Text("Browser")
                .fontWeight(.bold)
                .foregroundStyle(.exText)
                .padding(.top, 70)
            
            Text("選択したブラウザでURLを開くことができます。")
                .foregroundStyle(.exText)
                .padding(.top, 10)
                .font(.caption)
            
            List(CategoryColor.allCases, id: \.self) { color in
                Button {
                    rootEnvironment.setAppColor(color: color)
                    rootEnvironment.changeAppColor(color: color)
                } label: {
                    HStack {
                        
                        CategoryColor.getColor(color.rawValue)
                            .frame(width: categoryRowColorSize, height: categoryRowColorSize)
                            .clipShape(RoundedRectangle(cornerRadius: categoryRowColorSize))
                       
                        Text(color.name)
                        
                        Spacer()
                        
                        if rootEnvironment.appColor == CategoryColor.getColor(color.rawValue) {
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
