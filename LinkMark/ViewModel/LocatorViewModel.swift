//
//  LocatorListViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class LocatorViewModel: ObservableObject {
    
    @Published var locators: [Locator] = []
}

extension LocatorViewModel {
    
    public func fetchAllLocators(categoryId: String) {
        let predicate = NSPredicate(format: "category.id => %@", categoryId)
        locators = CoreDataRepository.fetch(predicate: predicate, sorts: [NSSortDescriptor(keyPath: \Locator.title, ascending: true)])
    }
    
    public func addLocator(title: String, url: URL, memo: String) {
        let entity: Locator = CoreDataRepository.entity()
        entity.id = UUID()
        entity.title = title
        entity.url = url
        entity.memo = memo
        entity.createdAt = Date()
        CoreDataRepository.insert(entity)
        CoreDataRepository.save()
    }
    
    public func onAppear(){
        fetchAllLocators(categoryId: "")
    }
}
