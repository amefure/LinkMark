//
//  UserDefaultsRepository.swift
//  LinkMark
//
//  Created by t&a on 2024/01/20.
//

import UIKit

class UserDefaultsKey {
    /// インタースティシャル広告の表示カウント
    static let COUNT_INTERSTITIAL = "CountInterstitial"
    /// 規定ブラウザ
    static let SELECT_BROWSER = "SELECT_BROWSER"
    /// アプリカラー
    static let APP_COLOR = "APP_COLOR"
}

/// UserDefaultsの基底クラス
class UserDefaultsRepository {

    private let userDefaults = UserDefaults.standard

    /// Bool：保存
    public func setBoolData(key: String, isOn: Bool) {
        userDefaults.set(isOn, forKey: key)
    }

    /// Bool：取得
    public func getBoolData(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }

    /// Int：保存
    public func setIntData(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }

    /// Int：取得
    public func getIntData(key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }

    /// String：保存
    public func setStringData(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }

    /// String：取得
    public func getStringData(key: String, initialValue: String = "") -> String {
        return userDefaults.string(forKey: key) ?? initialValue
    }
}

