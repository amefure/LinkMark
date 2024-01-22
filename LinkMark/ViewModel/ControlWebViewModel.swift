//
//  ControlWebViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/22.
//

import UIKit

class ControlWebViewModel {

    private let userDefaultsRepository: UserDefaultsRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    /// ブラウザを取得
    public func getSelectBrowser() -> BrowserConfig {
        let browser = userDefaultsRepository.getStringData(key: UserDefaultsKey.SELECT_BROWSER)
        return BrowserConfig(rawValue: browser) ?? BrowserConfig.safari
    }
}
