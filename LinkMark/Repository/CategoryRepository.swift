//
//  CategoryRepository.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import UIKit

class CategoryRepository {
    
    public func fetchAllCategorys() -> [Category] {
        return CoreDataRepository.fetch(sorts: [NSSortDescriptor(keyPath: \Category.order, ascending: true)])
    }
    
    public func addCategory(name: String, color: String, order: Int) {
        let entity: Category = CoreDataRepository.entity()
        entity.id = UUID()
        entity.name = name
        entity.color = color
        entity.order = Int16(order)
        CoreDataRepository.insert(entity)
        CoreDataRepository.save()
    }
    
    public func updateCategory(categoryId id : UUID, name: String, color: String) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let category: Category = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        category.name = name
        category.color = color
        
        CoreDataRepository.save()
    }

    
    public func updateOrder(categoryId id : UUID, order: Int) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let category: Category = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        category.order = Int16(order)
        
        CoreDataRepository.save()
    }

    public func deleteCategory(categoryId id : UUID) {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let category: Category = CoreDataRepository.fetchSingle(predicate: predicate) else { return }
        
        CoreDataRepository.delete(category)
        CoreDataRepository.save()
    }
}
