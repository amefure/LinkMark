//
//  RepositoryDependency.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import UIKit

class RepositoryDependency {
    public let categoryRepository = CategoryRepository()
    public let locatorRepository = LocatorRepository()
    public let biometricAuthRepository = BiometricAuthRepository()
    public let keyChainRepository = KeyChainRepository()
    public let userDefaultsRepository = UserDefaultsRepository()
}
