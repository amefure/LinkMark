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
    
    // 削除対象のCategoryが格納される
    @State private var category: Category? = nil
    
    @State private var showEditInputView = false
    @State private var showDeleteDialog = false
   
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack {
                
                HeaderView()
                
                ZStack {
                    
                    SectionTitleView(title: "Category")
                    
                    HStack {
                        
                        Spacer()
                        
                        
                        Button {
                            if rootViewModel.editSortMode == .active {
                                rootViewModel.inActiveEditMode()
                            } else {
                                rootViewModel.activeEditMode()
                            }
                            
                        } label: {
                            Image(systemName: "arrow.up.and.down.text.horizontal")
                                .foregroundStyle(rootViewModel.editSortMode == .active ? .exPositive : .exText)
                        }.offset(x: -30)
                    }
                    
                    
                }
                
                
                List {
                    ForEach(viewModel.categorys) { category in
                        
                        NavigationLink(value: ScreenPath.locatorList(category: category)) {
                            HStack {
                                CategoryColor.getColor(category.wrappedColor)
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                Text(category.wrappedName)
                                    .foregroundStyle(.exText)
                                
                                Spacer()
                                
                                Text("\(category.wrappedLocators.count)")
                                    .foregroundStyle(.exText)
                            }
                        }.listRowBackground(Color.exLightGray)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                // 右スワイプ：削除アクション
                                Button(role: .none) {
                                    self.category = category
                                    showDeleteDialog = true
                                } label: {
                                    Image(systemName: "trash")
                                }.tint(.exNegative)
                            }.swipeActions(edge: .leading, allowsFullSwipe: false) {
                                // 左スワイプ：編集アクション
                                Button(role: .none) {
                                    self.category = category
                                    showEditInputView = true
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                }.tint(.exPositive)
                            }
                    }.onMove { sourceSet, destination in
                        viewModel.changeOrder(list: viewModel.categorys, sourceSet: sourceSet, destination: destination)
                        
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
            }.offset(x: -30, y: -30)
            
        }.navigationBarBackButtonHidden()
            .onAppear {
                viewModel.onAppear()
            }
            .dialog(
                isPresented: $showDeleteDialog,
                title: "お知らせ",
                message: "「\(category?.wrappedName.limitLength ?? "")」を本当に削除しますか？\n削除するとリンクも全てなくなります。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "キャンセル",
                positiveAction: {
                    guard let category = category else { return }
                    viewModel.deleteCategory(category: category)
                    viewModel.fetchAllCategorys()
                },
                negativeAction: { showDeleteDialog = false }
            ).navigationDestination(isPresented: $showEditInputView) {
                CategoryInputView(category: category)
            }
        
    }
}

#Preview {
    CategoryListView()
}
