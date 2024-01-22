//
//  CategoryListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI
import Combine

struct CategoryListView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = CategoryViewModel.shared
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    @ObservedObject private var interstitial = AdmobInterstitialView()
    
    // 削除/更新対象のCategoryが格納される
    @State private var category: Category? = nil
    
    // MARK: - View
    @State private var showEditInputView = false
    @State private var showDeleteDialog = false
    @State private var showSettingView = false
    
    // MARK: - Combine
    @State private var cancellables: Set<AnyCancellable> = []
    
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
        ZStack(alignment: .bottomTrailing) {
            
            VStack {
                
                HeaderView(
                    trailingIcon: "gearshape.fill",
                    trailingAction: {
                        showSettingView = true
                    }
                )
                
                ZStack {
                    SectionTitleView(title: "Category")
                    
                    HStack {
                        // 並び替えボタン
                        Spacer()
                        Button {
                            if rootEnvironment.editSortMode == .active {
                                rootEnvironment.inActiveEditMode()
                            } else {
                                rootEnvironment.activeEditMode()
                            }
                        } label: {
                            Image(systemName: "arrow.up.and.down.text.horizontal")
                                .foregroundStyle(rootEnvironment.editSortMode == .active ? .exPositive : .exText)
                        }.offset(x: -30)
                    }
                }
                
                if viewModel.categorys.count == 0 {
                    FoundationImageView(title: "", msg: L10n.categoryNoData)
                } else {
                    List {
                        ForEach(viewModel.categorys) { category in
                            
                            NavigationLink(value: ScreenPath.locatorList(category: category)) {
                                HStack {
                                    CategoryColor.getColor(category.wrappedColor)
                                        .frame(width: categoryRowColorSize, height: categoryRowColorSize)
                                        .clipShape(RoundedRectangle(cornerRadius: categoryRowColorSize))
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
                }
                
                AdMobBannerView()
                    .frame(height: 60)
                
            }.environment(\.editMode, .constant(rootEnvironment.editSortMode))
            
            
            NavigationLink {
                CategoryInputView()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .frame(width: 55, height: 55)
                    .background(Color.exRed)
                    .clipShape(RoundedRectangle(cornerRadius: 55))
                    .shadow(color: .exText, radius: 2, x: 1, y: 1)
            }.offset(x: -30, y: -90)
            
        }.navigationBarBackButtonHidden()
            .onAppear {
                interstitial.loadInterstitial()
                viewModel.onAppear()
                
                rootEnvironment.$showInterstitial.sink { result in
                    if result {
                        interstitial.presentInterstitial()
                        rootEnvironment.resetShowInterstitial()
                    }
                }.store(in: &cancellables)
                
            }
            .dialog(
                isPresented: $showDeleteDialog,
                title: L10n.dialogTitle,
                message: L10n.dialogDeleteCategory(category?.wrappedName.limitLength ?? ""),
                positiveButtonTitle: L10n.dialogButtonOk,
                negativeButtonTitle: L10n.dialogButtonCancel,
                positiveAction: {
                    guard let category = category else { return }
                    viewModel.deleteCategory(category: category)
                    viewModel.fetchAllCategorys()
                },
                negativeAction: { showDeleteDialog = false }
            ).navigationDestination(isPresented: $showEditInputView) {
                CategoryInputView(category: category)
            }
            .navigationDestination(isPresented: $showSettingView) {
                SettingView()
            }
        
    }
}

#Preview {
    CategoryListView()
}
