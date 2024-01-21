//
//  LocatorListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct LocatorListView: View {
    
    // MARK: - View
    @ObservedObject private var viewModel = LocatorViewModel.shared
    @ObservedObject private var rootViewModel = RootEnvironment.shared
    
    // MARK: - Receive
    public var category: Category
    
    // 削除対象のLocatorが格納される
    @State private var locator: Locator? = nil
    
    // MARK: - Environment
    @State private var showEditInputView = false
    @State private var showDeleteDialog = false
    
    // MARK: - Environment
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
                
                if viewModel.locators.count == 0 {
                    FoundationImageView(title: "NO DATA", msg: L10n.locatorNoData)
                } else {
                    
                    List {
                        ForEach(viewModel.locators) { locator in
                            if let url = locator.url {
                                NavigationLink(value: ScreenPath.webView(url: url)) {
                                    VStack(alignment: .leading) {
                                        Text(locator.title!)
                                            .lineLimit(2)
                                        
                                        Text(locator.wrappedMemo)
                                            .font(.caption)
                                            .lineLimit(2)
                                            .padding([.leading, .vertical], 10)
                                        
                                        HStack {
                                            Text(DateFormatManager().getString(date: locator.wrappedCreatedAt))
                                            Text(url.absoluteString)
                                                .lineLimit(1)
                                        }.opacity(0.8)
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
                }
                
                Spacer()
            }
            
            NavigationLink {
                LocatorInputView(category: category)
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: 55, height: 55)
                    .background(CategoryColor.getColor(category.wrappedColor))
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .shadow(color: .exText, radius: 2, x: 1, y: 1)
            }.offset(x: -30, y: -30)
            
        }.background(Color.exThema)
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.onAppear(categoryId: category.wrappedId)
            }.dialog(
                isPresented: $showDeleteDialog,
                title: L10n.dialogTitle,
                message: L10n.dialogDeleteLocator(category.wrappedName.limitLength),
                positiveButtonTitle: L10n.dialogButtonOk,
                negativeButtonTitle: L10n.dialogButtonCancel,
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
