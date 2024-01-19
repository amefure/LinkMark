//
//  CategoryListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct CategoryListView: View {
    
    @ObservedObject private var viewModel = CategoryViewModel.shared
    @ObservedObject private var rootViewModel = RootViewModel.shared
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("LINKMARK")
                
                ZStack {
                    
                    SectionTitleView(title: "Category")
                    
                    Button {
                        if rootViewModel.editSortMode == .active {
                            rootViewModel.inActiveEditMode()
                        } else {
                            rootViewModel.activeEditMode()
                        }
                       
                    } label: {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                            .foregroundStyle(.exText)
                    }

                    
                }
               
                
                List {
                    ForEach(viewModel.categorys) { category in
                        NavigationLink {
                            LocatorListView(category: category)
                        } label: {
                            HStack {
                                CategoryColor.getColor(category.wrappedColor)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                                Text(category.wrappedName)
                                    .foregroundStyle(.exText)
                                
                                Spacer()
                                
                                Text("\(category.order)")
                                    .foregroundStyle(.exText)
                                
                                Text("\(category.wrappedLocators.count)")
                                    .foregroundStyle(.exText)
                            }
                        }.listRowBackground(Color.exLightGray)
                    }.onMove { sourceSet, destination in
                        viewModel.changeOrder(list: viewModel.categorys, sourceSet: sourceSet, destination: destination)
                    
                    }.onDelete { sourceSet in
                        
                    }.deleteDisabled(true)
                }.scrollContentBackground(.hidden)
                    .background(Color.exThema)
            }.environment(\.editMode, .constant(rootViewModel.editSortMode))
                
                
            
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
