//
//  SettingViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/20.
//

import UIKit

/// SettingView画面全域を管理するViewModel
/// 配下のViewも含めて管理
class SettingViewModel: ObservableObject {
    @Published var isShowPassInput: Bool = false
    @Published private(set) var isLock: Bool = false
    /// リワードボタン用
    @Published var isAlertReward: Bool = false

    private let keyChainRepository: KeyChainRepository
    private let userDefaultsRepository: UserDefaultsRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        keyChainRepository = repositoryDependency.keyChainRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }

    public func onAppear() {
        checkAppLock()
    }

    // MARK: - App Lock

    /// アプリにロックがかけてあるかをチェック
    private func checkAppLock() {
        isLock = keyChainRepository.getData().count == 4
    }

    /// パスワード入力画面を表示
    public func showPassInput() {
        isShowPassInput = true
    }

    /// アプリロックパスワードをリセット
    public func deletePassword() {
        keyChainRepository.delete()
    }

    // MARK: - Reward Logic

    // 容量追加
//    public func addCapacity() {
//        let current = getCapacity()
//        let capacity = current + AdsConfig.ADD_CAPACITY
//        userDefaultsRepository.setIntData(key: UserDefaultsKey.LIMIT_CAPACITY, value: capacity)
//    }
//
//    // 容量取得
//    public func getCapacity() -> Int {
//        let capacity = userDefaultsRepository.getIntData(key: UserDefaultsKey.LIMIT_CAPACITY)
//        if capacity < AdsConfig.INITIAL_CAPACITY {
//            userDefaultsRepository.setIntData(key: UserDefaultsKey.LIMIT_CAPACITY, value: AdsConfig.INITIAL_CAPACITY)
//            return AdsConfig.INITIAL_CAPACITY
//        } else {
//            return capacity
//        }
//    }

    /// 最終視聴日登録
    public func registerAcquisitionDate() {
        userDefaultsRepository.setStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE, value: nowTime())
    }

    /// 最終視聴日取得
    public func getAcquisitionDate() -> String {
        userDefaultsRepository.getStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE)
    }

    /// 最終視聴日チェック
    public func checkAcquisitionDate() -> Bool {
        // 格納してある日付と違えばtrue
        getAcquisitionDate() != nowTime()
    }

    /// 登録する視聴日
    private func nowTime() -> String {
        let dfm = DateFormatManager(format: "yyyy/MM/dd")
        return dfm.getString(date: Date())
    }



    // MARK: - Share Logic

    /// アプリシェアロジック
    public func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true, completion: {})
    }
}
