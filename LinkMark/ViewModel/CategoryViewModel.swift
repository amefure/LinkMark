//
//  CategoryListViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class CategoryViewModel: ObservableObject {
    
    static let shered = CategoryViewModel()
    
    @Published var categorys: [Category] = []
    
}

extension CategoryViewModel {
    
    public func fetchAllCategorys() {
        categorys = CoreDataRepository.fetch(sorts: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    }
    
    public func addCategory(name: String) {
        let entity: Category = CoreDataRepository.entity()
        entity.id = UUID()
        entity.name = name
        entity.color = CategoryColor.red.rawValue
        CoreDataRepository.insert(entity)
        CoreDataRepository.save()
    }
    
    public func onAppear(){
        fetchAllCategorys()
    }
}
