//
//  InputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//

import SwiftUI

struct InputView: View {
    
    public var placeholder: String
    @Binding var value: String
  
    var body: some View {
        
        TextField(placeholder, text: $value)
            .fontWeight(.bold)
            .padding([.horizontal], 10)
            .frame(height: DeviceSizeManager.isSESize ? 40 :  65)
            .background(Color.exLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.horizontal], 20)
            .foregroundStyle(.exText)   
    }
}

#Preview {
    InputView(placeholder: "placeholder", value: Binding.constant("Test"))
}
