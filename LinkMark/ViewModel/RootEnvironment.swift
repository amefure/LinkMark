//
//  RootViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import SwiftUI
import Combine

/// アプリ内で共通で利用される状態や環境値を保持する
class RootEnvironment: ObservableObject {
    
    static let shared = RootEnvironment()
    
    @Published var navigatePath: [ScreenPath] = []
    @Published private(set) var showInterstitial = false
    @Published private(set) var appLocked = false
    @Published private(set) var editSortMode: EditMode = .inactive
    @Published private(set) var selectBrowser: BrowserConfig = .safari
    @Published private(set) var appColor: Color = .exRed
    
    private var oldNavigatePath: [ScreenPath] = []
    private var countInterstitial: Int = 0
    
    private let keyChainRepository: KeyChainRepository
    private let userDefaultsRepository: UserDefaultsRepository
    
    private var cancellables: Set<AnyCancellable> = []

    private init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        keyChainRepository = repositoryDependency.keyChainRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
        setAppLock()
        
        getCountInterstitial()
        
        observeNavigatePath()
        
        changeAppColor(color: getAppColor())
        changeSelectBrowser(browser: getSelectBrowser())
    }
}

// MARK: - Status
extension RootEnvironment {
    /// ナビゲーションを観測してインタースティシャルをカウント
    private func observeNavigatePath() {
        $navigatePath
            .sink { [weak self] (newPath) in
                guard let self = self else { return }
                // カテゴリリストからLocatorリストに遷移した場合のみ
                if newPath.count == 1 && self.oldNavigatePath.count == 0 {
                    if let path = newPath.first {
                        switch path {
                        case .webView(url: _):
                            break
                        case .locatorList(category: _):
                            addCountInterstitial()
                            if self.countInterstitial >= AdsConfig.COUNT_INTERSTITIAL {
                                self.showInterstitial = true
                                resetCountInterstitial()
                                getCountInterstitial()
                            }
                        }
                    }
                }
                self.oldNavigatePath = newPath
            }.store(in: &cancellables)
    }

    /// アプリにロックがかけてあるかをチェック
    private func setAppLock() {
        appLocked = keyChainRepository.getData().count == 4
    }
    
    /// アプリにロックがかけてあるかをチェック
    public func unLockAppLock() {
        appLocked = false
    }
    
    public func activeEditMode() {
        editSortMode = .active
    }
    
    public func inActiveEditMode() {
        editSortMode = .inactive
    }
}


// MARK: - UserDefaultsRepository
extension RootEnvironment {
    
    /// インタースティシャル広告表示完了済みにする
    public func resetShowInterstitial() {
        showInterstitial = false
    }
    
    /// インタースティシャルリセット
    private func resetCountInterstitial() {
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL, value: 0)
    }
    
    /// インタースティシャルカウント
    private func addCountInterstitial() {
        countInterstitial += 1
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL, value: countInterstitial)
    }
    
    /// インタースティシャル取得
    private func getCountInterstitial() {
        countInterstitial = userDefaultsRepository.getIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL
        )
    }
    
    /// ブラウザを取得
    public func getSelectBrowser() -> BrowserConfig {
        let browser = userDefaultsRepository.getStringData(key: UserDefaultsKey.SELECT_BROWSER)
        return BrowserConfig(rawValue: browser) ?? BrowserConfig.safari
    }

    /// ブラウザを登録
    public func setSelectBrowser(browser: BrowserConfig) {
        userDefaultsRepository.setStringData(key: UserDefaultsKey.SELECT_BROWSER, value: browser.rawValue)
    }
    
    /// ブラウザを反映
    public func changeSelectBrowser(browser: BrowserConfig) {
        selectBrowser = browser
    }
    
    /// アプリカラーを取得
    public func getAppColor() -> CategoryColor {
        let color = userDefaultsRepository.getStringData(key: UserDefaultsKey.APP_COLOR)
        return CategoryColor(rawValue: color) ?? CategoryColor.red
    }

    /// アプリカラーを登録
    public func setAppColor(color: CategoryColor) {
        userDefaultsRepository.setStringData(key: UserDefaultsKey.APP_COLOR, value: color.rawValue)
    }
    
    /// アプリカラーを反映
    public func changeAppColor(color: CategoryColor) {
        appColor = CategoryColor.getColor(color.rawValue)
    }
}
