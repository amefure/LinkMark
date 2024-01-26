//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by t&a on 2024/01/25.
//

import UIKit
import Social
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let navigationController = self.navigationController else { return }
        // 上部ボタンの色
        navigationController.navigationBar.tintColor = .exText
        // 上部背景色
        navigationController.navigationBar.backgroundColor = .exThema

        // 上部ボタンの文言
        guard let controller = navigationController.viewControllers.first else { return }
        guard let rightBarButtonItem = controller.navigationItem.rightBarButtonItem else { return }
        rightBarButtonItem.title = "保存"
    }
    
    override func isContentValid() -> Bool {
        if let contentText = self.contentText, contentText.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    override func didSelectPost() {
        guard let contentText = self.contentText else { return }
        // タイトル保存
        let appGroupsRepository = AppGroupsRepository()
        appGroupsRepository.setStringData(key: AppGroupsKey.SHARE_EXTENSION_TITLE_KEY, value: contentText)
        
        // URL保存
        // 拡張コンテキストからinputItems：[NSExtensionItem]内にある最初の入力アイテムを取得
        guard let extensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem else { return }
        // 入力アイテムの中からattachments：[NSItemProvider]内にある最初のアタッチメントを取得
        guard let itemProvider = extensionItem.attachments?.first as? NSItemProvider else { return }
        // 「public.url」タイプのデータがあるかどうか確認
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
            // 非同期でURLを読み込む
            itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil, completionHandler: { (url, error) in
                // URLを取得
                if let url = url as? URL {
                    // 保存
                    appGroupsRepository.setStringData(key: AppGroupsKey.SHARE_EXTENSION_URL_KEY, value: url.absoluteString)
                    // 成功通知
                    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
                }
            })
        }
    
        // 投稿が成功したことをシステムに通知する
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func configurationItems() -> [Any]! {
        return []
    }
}
