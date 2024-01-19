//
//  LocatorListViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class LocatorViewModel: ObservableObject {
    
    static let shared = LocatorViewModel()
    
    @Published var locators: [Locator] = []
    
    private var locatorRepository: LocatorRepository
    private var categoryRepository: CategoryRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        locatorRepository = repositoryDependency.locatorRepository
        categoryRepository = repositoryDependency.categoryRepository
    }
}


extension LocatorViewModel {
    
    public func fetchAllLocators(categoryId: UUID) {
        locators = locatorRepository.fetchAllLocators(categoryId: categoryId)
    }
    
    public func addLocator(categoryId: UUID, title: String, url: URL, memo: String) {
        locatorRepository.addLocator(categoryId: categoryId, title: title, url: url, memo: memo)
    }
    
    public func onAppear(categoryId: UUID) {
        locators.removeAll()
        locators = locatorRepository.fetchAllLocators(categoryId: categoryId)
    }
    
    public func deleteCategory(category: Category) {
        let items = categoryRepository.fetchAllCategorys()
        
        guard items.count != 1 else {
            categoryRepository.deleteCategory(categoryId: category.wrappedId)
            return
        }
            
        // 削除する行の行番号を取得
        let deleteOrder = category.order
        
        // 削除する行の行番号より大きい行番号を全て -1 する
        for i in (Int(deleteOrder) + 1)..<items.count {
            if let item = items[safe: i] {
                categoryRepository.updateOrder(categoryId: item.wrappedId, order: Int(item.order) - 1)
            }
        }
        categoryRepository.deleteCategory(categoryId: category.wrappedId)
    }
}
