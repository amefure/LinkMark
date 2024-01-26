//
//  AppGroupsRepository.swift
//  LinkMark
//
//  Created by t&a on 2024/01/26.
//

import UIKit

class AppGroupsRepository {
    
    private let appGroupDefaults: UserDefaults?
    
    init() {
        appGroupDefaults = UserDefaults(suiteName: AppGroupsKey.GROUP_NAME)
    }
    
    /// String：保存
    public func setStringData(key: String, value: String) {
        guard let appGroupDefaults = appGroupDefaults else { return }
        appGroupDefaults.set(value, forKey: key)
    }

    /// String：取得
    public func getStringData(key: String, initialValue: String = "") -> String {
        guard let appGroupDefaults = appGroupDefaults else { return "" }
        return appGroupDefaults.string(forKey: key) ?? initialValue
    }
}
