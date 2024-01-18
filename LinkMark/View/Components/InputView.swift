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
            .padding([.horizontal], 10)
            .frame(height: 65)
            .background(Color.exLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.horizontal], 20)
    }
}

#Preview {
    InputView(placeholder: "placeholder", value: Binding.constant("Test"))
}
