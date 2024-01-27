//
//  ShareViewModel.swift
//  ShareExtension
//
//  Created by t&a on 2024/01/27.
//

import UIKit

class ShareViewModel {

    static let shared = ShareViewModel()
    
    public var categorys: [Category] = []
    
    private var locatorRepository: LocatorRepository
    private var categoryRepository: CategoryRepository
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        locatorRepository = repositoryDependency.locatorRepository
        categoryRepository = repositoryDependency.categoryRepository
        
        categorys = categoryRepository.fetchAllCategorys()
    }
    
    private func fetchAllLocatorsCount(categoryId: UUID) -> Int {
        let locators = locatorRepository.fetchAllLocators(categoryId: categoryId)
        return locators.count
    }
    
    public func addLocator(categoryId: UUID, title: String, url: URL, memo: String) {
        let order = fetchAllLocatorsCount(categoryId: categoryId)
        locatorRepository.addLocator(categoryId: categoryId, title: title, url: url, memo: memo, order: order)
    }
}
