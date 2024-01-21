//
//  Category+CoreDataClass.swift
//  
//
//  Created by t&a on 2024/01/10.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    // 値がnilの場合のデフォルト値定義
    public var wrappedId: UUID { id ?? UUID() }
    public var wrappedName: String { name ?? "" }
    public var wrappedColor: String { color ?? CategoryColor.red.rawValue }
    public var wrappedLocators: NSSet { locator ?? NSSet() }
    public var wrappedOrder: Int { Int(order) }
}


extension Category {
    
    /// デモプレビュー用インスタンス生成メソッド
    static func new(name: String, color: String, order: Int) -> Category {
        let entity: Category = CoreDataRepository.entity()
        entity.id = UUID()
        entity.name = name
        entity.color = color
        entity.order = Int16(order)
        return entity
    }
   
    /// デモリスト
    static var demoCategorys : [Category] {
        
        var categorys: [Category]  = []
        
        let category1 = Category.new(name: "料理", color: "red", order: 0)
        categorys.append(category1)
        
        let category2 = Category.new(name: "趣味", color: "yellow", order: 1)
        categorys.append(category2)
        
        let category3 = Category.new(name: "勉強", color: "blue", order: 2)
        categorys.append(category3)
        
        let category4 = Category.new(name: "子供", color: "green", order: 3)
        categorys.append(category4)
        
        let category5 = Category.new(name: "テニス", color: "purple", order: 4)
        categorys.append(category5)
        
        return categorys
    }
    
    /// デモリスト
    static var demoCategorysEn : [Category] {
        
        var categorys: [Category]  = []
        
        let category1 = Category.new(name: "Cooking", color: "red", order: 0)
        categorys.append(category1)
        
        let category2 = Category.new(name: "Hobby", color: "yellow", order: 1)
        categorys.append(category2)
        
        let category3 = Category.new(name: "Study", color: "blue", order: 2)
        categorys.append(category3)
        
        let category4 = Category.new(name: "Child", color: "green", order: 3)
        categorys.append(category4)
        
        let category5 = Category.new(name: "Tennis", color: "purple", order: 4)
        categorys.append(category5)
        
        return categorys
    }
}

