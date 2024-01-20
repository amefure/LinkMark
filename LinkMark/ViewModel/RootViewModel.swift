//
//  RootViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/20.
//

import UIKit

class RootViewModel {
    private let keyChainRepository: KeyChainRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        keyChainRepository = repositoryDependency.keyChainRepository
    }

    /// アプリにロックがかけてあるかをチェック
    public func checkAppLock() -> Bool {
        keyChainRepository.getData().count == 4
    }
}
