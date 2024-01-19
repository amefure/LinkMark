//
//  EXCollection.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import UIKit

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
