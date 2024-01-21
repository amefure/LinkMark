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

extension Locator {
    
    /// デモプレビュー用インスタンス生成メソッド
    static func new(title: String, url: URL, memo: String, order: Int) -> Locator {
        let entity: Locator = CoreDataRepository.entity()
        entity.id = UUID()
        entity.title = title
        entity.url = url
        entity.memo = memo
        entity.order = Int16(order)
        entity.createdAt = Date()
        return entity
    }
   
    /// デモリスト
    static var demoLocators : [Locator] {
        
        var locators: [Locator]  = []
        
        let locator1 = Locator.new(title: "肉じゃがの作り方(3人前)", url: URL(string: "https://tech.amefure.com/")!, memo: "", order: 0)
        locators.append(locator1)
        
        let locator2 = Locator.new(title: "麻婆豆腐レシピ", url: URL(string: "https://www.google.co.jp/")!, memo: "豆板醤が必要", order: 1)
        locators.append(locator2)
        
        let locator3 = Locator.new(title: "作り置きまとめサイト", url: URL(string: "https://portfolio.amefure.com/")!, memo: "", order: 2)
        locators.append(locator3)
        
        let locator4 = Locator.new(title: "野菜の選び方特集", url: URL(string: "https://www.amefure.com")!, memo: "・ほうれん草は茹でる", order: 3)
        locators.append(locator4)
        
        let locator5 = Locator.new(title: "トマトを使ったレシピ", url: URL(string: "https://www.qa-mikata.com/")!, memo: "", order: 4)
        locators.append(locator5)
        
        return locators
    }
    
    static var demoLocatorsEn : [Locator] {
        
        var locators: [Locator]  = []
        
        let locator1 = Locator.new(title: "How to make steak", url: URL(string: "https://tech.amefure.com/")!, memo: "", order: 0)
        locators.append(locator1)
        
        let locator2 = Locator.new(title: "How to choose vegetables", url: URL(string: "https://www.google.co.jp/")!, memo: "", order: 1)
        locators.append(locator2)
        
        let locator3 = Locator.new(title: "5 recommended cafes", url: URL(string: "https://portfolio.amefure.com/")!, memo: "", order: 2)
        locators.append(locator3)
        
        let locator4 = Locator.new(title: "useful kitchen goods", url: URL(string: "https://www.amefure.com")!, memo: "", order: 3)
        locators.append(locator4)
        
        let locator5 = Locator.new(title: "Recipes using tomatoes", url: URL(string: "https://www.qa-mikata.com/")!, memo: "", order: 4)
        locators.append(locator5)
        
        return locators
    }
}

