//
//  ScreenPath.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import UIKit

enum ScreenPath: Hashable {
    case webView(url: URL)
    case locatorList(category: Category)
}
