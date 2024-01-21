//
//  ReachabilityUtility.swift
//  LinkMark
//
//  Created by t&a on 2024/01/21.
//

import UIKit
import Reachability

class ReachabilityUtility {

    private let reachability: Reachability? = nil
    
    init() {
        do {
            let reachability = try Reachability()
        } catch {
            print("Reachabilityインスタンス生成失敗")
        }
    }
    
    public var isAvailable: Bool {
        guard let reachability = reachability else { return false }
        switch reachability.connection {
        case .wifi:
            return true
        case .cellular:
            return true
        case .unavailable:
            return false
        case .none:
            return false
        }
    }
}
