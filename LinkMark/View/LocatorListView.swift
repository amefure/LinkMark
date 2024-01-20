//
//  LocatorListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct LocatorListView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel.shared
    @ObservedObject private var rootViewModel = RootViewModel.shared
    
    public var category: Category
    
    // 削除対象のLocatorが格納される
    @State private var locator: Locator? = nil
    
    @State private var showEditInputView = false
    @State private var showDeleteDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HeaderView(leadingIcon: "arrow.backward", leadingAction: {
                    dismiss()
                })
                
                ZStack {
                    SectionTitleView(title: "Link")
                    
                    Text(category.wrappedName)
                        .foregroundStyle(.exText)
                        .frame(width: 150, height: 40)
                        .background(CategoryColor.getColor(category.wrappedColor))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
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
                    ForEach(viewModel.locators) { locator in
                        if let url = locator.url {
                            NavigationLink(value: ScreenPath.webView(url: url)) {
                                VStack(alignment: .leading) {
                                    Text(locator.title!)
                                    
                                    Text(locator.wrappedMemo)
                                        .font(.caption)
                                        .frame(height: 30)
                                    
                                    HStack {
                                        Text(DateFormatManager().getString(date: locator.wrappedCreatedAt))
                                        Text(url.absoluteString)
                                    }.opacity(5)
                                        .font(.caption)
                                }.foregroundStyle(.exText)
                            }.listRowBackground(Color.exLightGray)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    // 右スワイプ：削除アクション
                                    Button(role: .none) {
                                        self.locator = locator
                                        showDeleteDialog = true
                                    } label: {
                                        Image(systemName: "trash")
                                    }.tint(.exNegative)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    // 左スワイプ：編集アクション
                                    Button(role: .none) {
                                        self.locator = locator
                                        showEditInputView = true
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }.tint(.exPositive)
                                }
                        }
                    }.onMove { sourceSet, destination in
                        viewModel.changeOrder(categoryId: category.wrappedId, list: viewModel.locators, sourceSet: sourceSet, destination: destination)
                        
                    }.deleteDisabled(true)
                }.environment(\.editMode, .constant(rootViewModel.editSortMode))
                    .scrollContentBackground(.hidden)
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
            }.offset(x: -30, y: -30)
            
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.onAppear(categoryId: category.wrappedId)
            }.dialog(
                isPresented: $showDeleteDialog,
                title: "お知らせ",
                message: "「\(category.wrappedName.limitLength)」を本当に削除しますか？",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "キャンセル",
                positiveAction: {
                    guard let locator = locator else { return }
                    viewModel.deleteCategory(locator: locator)
                    viewModel.fetchAllLocators(categoryId: category.wrappedId)
                },
                negativeAction: { showDeleteDialog = false }
            ).navigationDestination(isPresented: $showEditInputView) {
                LocatorInputView(category: category, locator: locator)
            }
    }
}

//#Preview {
//    LocatorListView(category: )
//}
