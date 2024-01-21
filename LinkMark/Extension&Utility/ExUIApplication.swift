//
//  ExUIApplication.swift
//  LinkMark
//
//  Created by t&a on 2024/01/21.
//

import UIKit

extension UIApplication {
    /// フォーカスの制御をリセット
    /// キーボードを閉じさせる
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
