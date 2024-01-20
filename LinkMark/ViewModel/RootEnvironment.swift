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
    
    private let keyChainRepository: KeyChainRepository
    private let userDefaultsRepository: UserDefaultsRepository
    
    @Published var navigatePath: [ScreenPath] = []
    @Published private(set) var showInterstitial = false
    @Published private(set) var appLocked = false
    @Published private(set) var editSortMode: EditMode = .inactive
    
    private var oldNavigatePath: [ScreenPath] = []
    private var countInterstitial: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []

    private init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        keyChainRepository = repositoryDependency.keyChainRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
        setAppLock()
        
        getCountInterstitial()
        
        observeNavigatePath()
    }
    
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
            }
            .store(in: &cancellables)
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
}






