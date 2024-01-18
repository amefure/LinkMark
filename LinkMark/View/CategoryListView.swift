//
//  CategoryListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject private var viewModel = CategoryViewModel.shered
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("LINKMARK")
                
                SectionTitleView(title: "Category")
                
                List {
                    ForEach(viewModel.categorys) { category in
                        NavigationLink {
                            LocatorListView()
                        } label: {
                            HStack {
                                CategoryColor.getColor(category.wrappedColor)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                                Text(category.wrappedName)
                                    .foregroundStyle(.exText)
                                
                                Spacer()
                                
                                Text("\(category.wrappedLocators.count)")
                                    .foregroundStyle(.exText)
                            }
                        }.listRowBackground(Color.exLightGray)
                    }
                }.scrollContentBackground(.hidden)
                    .background(Color.exThema)
            }
                
            
            NavigationLink {
                CategoryInputView()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.exText)
                    .fontWeight(.bold)
                    .frame(width: 70, height: 70)
                    .background(Color.exLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 70))
                    .shadow(color: .exText, radius: 2, x: 1, y: 1)
            }

        }.onAppear {
            viewModel.onAppear()
        }
        
    }
}

#Preview {
    CategoryListView()
}
