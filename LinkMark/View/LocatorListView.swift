//
//  LocatorListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct LocatorListView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel.shered
    
    
    public var category: Category
    var body: some View {
        ZStack {
            VStack {
                Text("LINKMARK")
                
                ZStack {
                    SectionTitleView(title: "Link")
                    
                    Text(category.wrappedName)
                        .foregroundStyle(.exText)
                        .frame(width: 150, height: 40)
                        .background(CategoryColor.getColor(category.wrappedColor))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                
                List {
                    ForEach(viewModel.locators) { locator in
                        Text(locator.title!)
                            .listRowBackground(Color.exLightGray)
                        Text(locator.category!.wrappedId.uuidString)
                            .listRowBackground(Color.exLightGray)
                    }
                }.scrollContentBackground(.hidden)
                    .background(Color.exThema)
                
                Spacer()
            }
            
            NavigationLink {
                LocatorInputView(category: category)
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.exText)
                    .fontWeight(.bold)
                    .frame(width: 70, height: 70)
                    .background(Color.exLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 70))
                    .shadow(color: .exText, radius: 2, x: 1, y: 1)
            }
        }.background(Color.exThema)
            .onAppear {
                viewModel.onAppear(categoryId: category.wrappedId)
            }
    }
}

//#Preview {
//    LocatorListView(category: )
//}
