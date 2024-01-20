//
//  CategoryListViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class CategoryViewModel: ObservableObject {
    
    static let shared = CategoryViewModel()
    
    @Published var categorys: [Category] = []

    private var categoryRepository: CategoryRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        categoryRepository = repositoryDependency.categoryRepository
    }
}

extension CategoryViewModel {
    
    public func fetchAllCategorys() {
        categorys = categoryRepository.fetchAllCategorys()
    }
    
    public func addCategory(name: String, color: String) {
        categoryRepository.addCategory(name: name, color: color, order: categorys.count)
    }
    
    public func updateCategory(id: UUID, name: String, color: String) {
        categoryRepository.updateCategory(categoryId: id, name: name, color: color)
    }
    
    private func updateOrder(id: UUID, order: Int) {
        categoryRepository.updateOrder(categoryId: id, order: order)
    }
    
    public func onAppear(){
        fetchAllCategorys()
    }
    
    
    public func changeOrder(list: [Category], sourceSet: IndexSet, destination: Int) {
        guard let source = sourceSet.first else { return }
        
        let items = list.sorted(by: { $0.order < $1.order })
        
        let moveId = items[source].wrappedId
        
        // 上から下に移動する
        if source < destination {
            for i in (source + 1)...(destination - 1) {
                if let item = items[safe: i] {
                    updateOrder(id: item.wrappedId, order: item.wrappedOrder - 1)
                }
            }
            updateOrder(id: moveId, order: destination - 1)
            
            // 下から上に移動する
        } else if destination < source {
            for i in (destination...(source - 1)).reversed() {
                if let item = items[safe: i] {
                    updateOrder(id: item.wrappedId, order: item.wrappedOrder + 1)
                }
            }
            updateOrder(id: moveId, order: destination)
        }
        fetchAllCategorys()
    }
    
    public func deleteCategory(category: Category) {
        guard categorys.count != 1 else {
            categoryRepository.deleteCategory(categoryId: category.wrappedId)
            return
        }
            
        // 削除する行の行番号を取得
        let deleteOrder = category.order
        
        // 削除する行の行番号より大きい行番号を全て -1 する
        for i in (Int(deleteOrder) + 1)..<categorys.count {
            if let item = categorys[safe: i] {
                categoryRepository.updateOrder(categoryId: item.wrappedId, order: Int(item.order) - 1)
            }
        }
        categoryRepository.deleteCategory(categoryId: category.wrappedId)
    }
}
