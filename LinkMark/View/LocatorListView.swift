//
//  LocatorListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct LocatorListView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel.shared
    
    @State private var showDeleteDialog = false
    public var category: Category
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
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
                            showDeleteDialog = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.exRed)
                        }
                    }
                    
                }
                
                
                List {
                    ForEach(viewModel.locators) { locator in
                        if let url = locator.url {
                            
                            NavigationLink(value: ScreenPath.pathA(url: url)) {
                                VStack(alignment: .leading) {
                                    Text(locator.title!)
                                    
                                    Text(locator.wrappedMemo)
                                    
                                    HStack {
                                        Text(DateFormatManager().getString(date: locator.wrappedCreatedAt))
                                        Text(url.absoluteString)
                                    }.opacity(5)
                                        .font(.caption)
                                }.foregroundStyle(.exText)
                            }.listRowBackground(Color.exLightGray)
                        }
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
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.onAppear(categoryId: category.wrappedId)
            }.dialog(
                isPresented: $showDeleteDialog,
                title: "お知らせ",
                message: "「\(category.wrappedName.limitLength)」を本当に削除しますか？\n削除するとリンクも全てなくなります。",
                positiveButtonTitle: "OK",
                negativeButtonTitle: "キャンセル",
                positiveAction: {
                    viewModel.deleteCategory(category: category)
                    dismiss()
                },
                negativeAction: { showDeleteDialog = false }
            )
    }
}

struct Test: View {
    @Environment(\.presentationMode) var presentation
    init() {
        print("INSTANSS")
    }
    var body: some View {
     Text("DD")
    }
}

//#Preview {
//    LocatorListView(category: )
//}
