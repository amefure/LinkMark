//
//  CategoryInputView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/11.
//

import SwiftUI

struct CategoryInputView: View {
    
    @ObservedObject private var viewModel = CategoryViewModel.shered
    
    @State private var name = ""
    var body: some View {
        
        TextField("", text: $name)
    
        
        
        Button {
            viewModel.addCategory(name: name)
        } label: {
            Text("登録")
        }

    }
}

#Preview {
    CategoryInputView()
}
