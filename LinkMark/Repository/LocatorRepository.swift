//
//  LocatorRepository.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import UIKit

class LocatorRepository {

    public func fetchAllLocators(categoryId: UUID) -> [Locator] {
        let predicate = NSPredicate(format: "category.id == %@", categoryId as CVarArg)
        return CoreDataRepository.fetch(predicate: predicate, sorts: [NSSortDescriptor(keyPath: \Locator.order, ascending: true)])
    }
    
    public func addLocator(categoryId: UUID, title: String, url: URL, memo: String, order: Int) {
        let predicate = NSPredicate(format: "id == %@", categoryId as CVarArg)
        guard let category: Category = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        guard let context = category.managedObjectContext  else { return }
        
        let entity = Locator(context: context)
        entity.id = UUID()
        entity.title = title
        entity.url = url
        entity.memo = memo
        entity.order = Int16(order)
        entity.createdAt = Date()
        category.addToLocator(entity)
        
        CoreDataRepository.save()
    }
    
    public func updateLocator(locatorId id : UUID,  title: String, url: URL, memo: String) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let locator: Locator = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        locator.title = title
        locator.url = url
        locator.memo = memo
        CoreDataRepository.save()
    }
    
    public func updateOrder(locatorId id : UUID, order: Int) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let locator: Locator = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        locator.order = Int16(order)
        CoreDataRepository.save()
    }

    public func deleteLocator(locatorId id : UUID) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let locator: Locator = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        CoreDataRepository.delete(locator)
        CoreDataRepository.save()
    }

}
