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

}


extension Category {
   
    // 値がnilの場合のデフォルト値定義
    public var wrappedId: UUID { id ?? UUID() }
    public var wrappedName: String { name ?? "" }
    public var wrappedColor: String { color ?? CategoryColor.red.rawValue }
    public var wrappedLocators: NSSet { locator ?? NSSet() }
    public var wrappedOrder: Int { Int(order) }
    

}

