//
//  Locator+CoreDataClass.swift
//  
//
//  Created by t&a on 2024/01/10.
//
//

import Foundation
import CoreData

@objc(Locator)
public class Locator: NSManagedObject {

    // 値がnilの場合のデフォルト値定義
    public var wrappedId: UUID { id ?? UUID() }
    public var wrappedTitle: String { title ?? "" }
    public var wrappedMemo: String { memo ?? "" }
    public var wrappedCreatedAt: Date { createdAt ?? Date() }
    public var wrappedOrder: Int { Int(order) }
    
}

