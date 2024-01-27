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
    
    private var viewModel = ShareViewModel.shared
    private var selectedCategory: Category?
    
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
        rightBarButtonItem.title = L10n.shareExtenstionSheetSave
    }
    
    override func isContentValid() -> Bool {
        if let contentText = self.contentText, contentText.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    override func didSelectPost() {
        guard let title = self.contentText else { return }
        
        // URL保存
        // 拡張コンテキストからinputItems：[NSExtensionItem]内にある最初の入力アイテムを取得
        guard let extensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem else { return }
        // 入力アイテムの中からattachments：[NSItemProvider]内にある最初のアタッチメントを取得
        guard let itemProvider = extensionItem.attachments?.first as? NSItemProvider else { return }
        // 「public.url」タイプのデータがあるかどうか確認
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
            // 非同期でURLを読み込む
            itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil, completionHandler: { [weak self] (url, error) in
                guard let self = self else { return }
                // URLを取得
                if let url = url as? URL, let category = self.selectedCategory {
                    // Core Dataに保存する
                    self.viewModel.addLocator(categoryId: category.wrappedId, title: title, url: url, memo: "")
                    
                    // メインスレッドで成功を通知しないとクラッシュする
                    DispatchQueue.main.async {
                        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
                    }
                }
            })
        }
    }
    
    override func configurationItems() -> [Any]! {
        
        guard let item = SLComposeSheetConfigurationItem() else { return [] }
        
        guard let category = viewModel.categorys.first else { return [] }
        self.selectedCategory = category
        item.title = "Category"
        item.value = category.wrappedName
        item.tapHandler = {
            // ピッカー位置調整用
            let title = L10n.shareExtenstionAlertTitle
            let message = "\n\n\n\n\n\n\n\n"
            // アラートコントローラーの作成
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            // ピッカービューの作成
            let pickerView = UIPickerView()
            pickerView.frame = CGRectMake(0, 50, alertController.view.bounds.width, 150) // 配置、サイズ
            pickerView.dataSource = self
            pickerView.delegate = self

            // アラートコントローラーにピッカービューを追加
            alertController.view.addSubview(pickerView)


            // アクションの追加（"OK"ボタンを押したときの処理）
            let okAction = UIAlertAction(title: L10n.shareExtenstionAlertDecision, style: .default) { _ in
                // ピッカーで選択された値を取得するなどの処理を追加

                // 例: 選択されたカテゴリーを取得
                let selectedRow = pickerView.selectedRow(inComponent: 0)
                self.selectedCategory = self.viewModel.categorys[selectedRow]

                // 設定値を更新
                item.value = self.selectedCategory?.wrappedName

                // シートを再読み込み
                self.reloadInputViews()
            }

            alertController.addAction(okAction)

            // アラートコントローラーを表示
            self.present(alertController, animated: true, completion: nil)
        }
        return [item]
    }
}

extension ShareViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 列数
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        return viewModel.categorys.count
    }
    
    // 最初に選択状態にする行データ
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {
        return viewModel.categorys[safe: row]?.wrappedName ?? nil
    }
}

