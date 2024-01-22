//
//  LocatorListViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class LocatorViewModel: ObservableObject {
    
    static let shared = LocatorViewModel()
    
    @Published private(set) var locators: [Locator] = []
    
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
        // locators = Locator.demoLocators
    }
    
    public func addLocator(categoryId: UUID, title: String, url: URL, memo: String) {
        locatorRepository.addLocator(categoryId: categoryId, title: title, url: url, memo: memo, order: locators.count)
    }
    
    public func updateLocator(id: UUID, title: String, url: URL, memo: String) {
        locatorRepository.updateLocator(locatorId: id, title: title, url: url, memo: memo)
    }
    
    private func updateOrder(id: UUID, order: Int) {
        locatorRepository.updateOrder(locatorId: id, order: order)
    }
    
    public func onAppear(categoryId: UUID) {
        locators.removeAll()
        fetchAllLocators(categoryId: categoryId)
    }
    
    public func changeOrder(categoryId: UUID, list: [Locator], sourceSet: IndexSet, destination: Int) {
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
        fetchAllLocators(categoryId: categoryId)
    }
    
    public func deleteCategory(locator: Locator) {
        guard locators.count != 1 else {
            locatorRepository.deleteLocator(locatorId: locator.wrappedId)
            return
        }
            
        // 削除する行の行番号を取得
        let deleteOrder = locator.order
        
        // 削除する行の行番号より大きい行番号を全て -1 する
        for i in (Int(deleteOrder) + 1)..<locators.count {
            if let item = locators[safe: i] {
                locatorRepository.updateOrder(locatorId: item.wrappedId, order: Int(item.order) - 1)
            }
        }
        locatorRepository.deleteLocator(locatorId: locator.wrappedId)
    }
    
   
}
