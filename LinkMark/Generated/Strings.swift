// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Face IDでログインする
  internal static let appLockFaceId = L10n.tr("Localizable", "app_lock_face_id", fallback: "Face IDでログインする")
  /// パスワードが違います。
  internal static let appLockFailedPassword = L10n.tr("Localizable", "app_lock_failed_password", fallback: "パスワードが違います。")
  /// 登録
  internal static let appLockInputEntryButton = L10n.tr("Localizable", "app_lock_input_entry_button", fallback: "登録")
  /// パスワード登録
  internal static let appLockInputTitle = L10n.tr("Localizable", "app_lock_input_title", fallback: "パスワード登録")
  /// Touch IDでログインする
  internal static let appLockTouchId = L10n.tr("Localizable", "app_lock_touch_id", fallback: "Touch IDでログインする")
  /// スカイブルー
  internal static let appThemaColorBlue = L10n.tr("Localizable", "app_thema_color_blue", fallback: "スカイブルー")
  /// ミントグリーン
  internal static let appThemaColorGreen = L10n.tr("Localizable", "app_thema_color_green", fallback: "ミントグリーン")
  /// ラベンダー
  internal static let appThemaColorPurple = L10n.tr("Localizable", "app_thema_color_purple", fallback: "ラベンダー")
  /// ローズピンク
  internal static let appThemaColorRed = L10n.tr("Localizable", "app_thema_color_red", fallback: "ローズピンク")
  /// ライトイエロー
  internal static let appThemaColorYellow = L10n.tr("Localizable", "app_thema_color_yellow", fallback: "ライトイエロー")
  /// 例：レシピ・趣味など
  internal static let categoryInputPlaceholder = L10n.tr("Localizable", "category_input_placeholder", fallback: "例：レシピ・趣味など")
  /// カテゴリを登録してね♪
  internal static let categoryNoData = L10n.tr("Localizable", "category_no_data", fallback: "カテゴリを登録してね♪")
  /// yyyy年M月d日
  internal static let dateFormat = L10n.tr("Localizable", "date_format", fallback: "yyyy年M月d日")
  /// Localizable.strings
  ///   LinkMark
  /// 
  ///   Created by t&a on 2024/01/04.
  internal static let dateLocale = L10n.tr("Localizable", "date_locale", fallback: "ja_JP")
  /// キャンセル
  internal static let dialogButtonCancel = L10n.tr("Localizable", "dialog_button_cancel", fallback: "キャンセル")
  /// OK
  internal static let dialogButtonOk = L10n.tr("Localizable", "dialog_button_ok", fallback: "OK")
  /// 「%@」を本当に削除しますか？
  /// 削除するとリンクも全てなくなります。
  internal static func dialogDeleteCategory(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_delete_category_%@", String(describing: p1), fallback: "「%@」を本当に削除しますか？\n削除するとリンクも全てなくなります。")
  }
  /// 「%@」を本当に削除しますか？
  internal static func dialogDeleteLocator(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_delete_locator_%@", String(describing: p1), fallback: "「%@」を本当に削除しますか？")
  }
  /// カテゴリ「%@」を
  /// 登録しました。
  internal static func dialogEntryCategory(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_entry_category_%@", String(describing: p1), fallback: "カテゴリ「%@」を\n登録しました。")
  }
  /// リンク「%@」を
  /// 登録しました。
  internal static func dialogEntryLocator(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_entry_locator_%@", String(describing: p1), fallback: "リンク「%@」を\n登録しました。")
  }
  /// お知らせ
  internal static let dialogTitle = L10n.tr("Localizable", "dialog_title", fallback: "お知らせ")
  /// カテゴリ「%@」を
  /// 更新しました。
  internal static func dialogUpdateCategory(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_update_category_%@", String(describing: p1), fallback: "カテゴリ「%@」を\n更新しました。")
  }
  /// リンク「%@」を
  /// 更新しました。
  internal static func dialogUpdateLocator(_ p1: Any) -> String {
    return L10n.tr("Localizable", "dialog_update_locator_%@", String(describing: p1), fallback: "リンク「%@」を\n更新しました。")
  }
  /// カテゴリ名は必須入力です。
  internal static let dialogValidationCategory = L10n.tr("Localizable", "dialog_validation_category", fallback: "カテゴリ名は必須入力です。")
  /// タイトルを取得できませんでした。
  internal static let locatorInputFailedGetTitleMsg = L10n.tr("Localizable", "locator_input_failed_get_title_msg", fallback: "タイトルを取得できませんでした。")
  /// Linkから取得
  internal static let locatorInputGetTitleButton = L10n.tr("Localizable", "locator_input_get_title_button", fallback: "Linkから取得")
  /// リンクタイトル
  internal static let locatorInputPlaceholderTitle = L10n.tr("Localizable", "locator_input_placeholder_title", fallback: "リンクタイトル")
  /// https://XXX.com/
  internal static let locatorInputPlaceholderUrl = L10n.tr("Localizable", "locator_input_placeholder_url", fallback: "https://XXX.com/")
  /// ・タイトルは必須入力です。
  internal static let locatorInputValidationTitle = L10n.tr("Localizable", "locator_input_validation_title", fallback: "・タイトルは必須入力です。")
  /// ・有効なリンクを入力してください。
  internal static let locatorInputValidationUrl = L10n.tr("Localizable", "locator_input_validation_url", fallback: "・有効なリンクを入力してください。")
  /// Linkを登録してね♪
  internal static let locatorNoData = L10n.tr("Localizable", "locator_no_data", fallback: "Linkを登録してね♪")
  /// 選択したブラウザでURLを開くことができます。
  internal static let selectBrowserText = L10n.tr("Localizable", "select_browser_text", fallback: "選択したブラウザでURLを開くことができます。")
  /// アプリのテーマカラーを選択することができます。
  internal static let selectColorText = L10n.tr("Localizable", "select_color_text", fallback: "アプリのテーマカラーを選択することができます。")
  /// 起動するブラウザを変更する
  internal static let settingSectionAppBrowser = L10n.tr("Localizable", "setting_section_app_browser", fallback: "起動するブラウザを変更する")
  /// アプリのテーマカラーを変更する
  internal static let settingSectionAppColor = L10n.tr("Localizable", "setting_section_app_color", fallback: "アプリのテーマカラーを変更する")
  /// ・アプリにパスワードを設定してロックをかけることができます。
  internal static let settingSectionAppDesc = L10n.tr("Localizable", "setting_section_app_desc", fallback: "・アプリにパスワードを設定してロックをかけることができます。")
  /// アプリをロックする
  internal static let settingSectionAppLock = L10n.tr("Localizable", "setting_section_app_lock", fallback: "アプリをロックする")
  /// アプリ設定
  internal static let settingSectionAppTitle = L10n.tr("Localizable", "setting_section_app_title", fallback: "アプリ設定")
  /// アプリの不具合はこちら
  internal static let settingSectionLinkContact = L10n.tr("Localizable", "setting_section_link_contact", fallback: "アプリの不具合はこちら")
  /// ・アプリに不具合がございましたら「アプリの不具合はこちら」よりお問い合わせください。
  internal static let settingSectionLinkDesc = L10n.tr("Localizable", "setting_section_link_desc", fallback: "・アプリに不具合がございましたら「アプリの不具合はこちら」よりお問い合わせください。")
  /// 「LINKMARK」をオススメする
  internal static let settingSectionLinkRecommend = L10n.tr("Localizable", "setting_section_link_recommend", fallback: "「LINKMARK」をオススメする")
  /// アプリをレビューする
  internal static let settingSectionLinkReview = L10n.tr("Localizable", "setting_section_link_review", fallback: "アプリをレビューする")
  /// 利用規約とプライバシーポリシー
  internal static let settingSectionLinkTerms = L10n.tr("Localizable", "setting_section_link_terms", fallback: "利用規約とプライバシーポリシー")
  /// 決定
  internal static let shareExtenstionAlertDecision = L10n.tr("Localizable", "share_extenstion_alert_decision", fallback: "決定")
  /// カテゴリ選択
  internal static let shareExtenstionAlertTitle = L10n.tr("Localizable", "share_extenstion_alert_title", fallback: "カテゴリ選択")
  /// 保存
  internal static let shareExtenstionSheetSave = L10n.tr("Localizable", "share_extenstion_sheet_save", fallback: "保存")
  /// ネットワークに接続されていません。
  /// 通信環境の整った場所でご利用ください。
  internal static let webviewNetworkUnavailable = L10n.tr("Localizable", "webview_network_unavailable", fallback: "ネットワークに接続されていません。\n通信環境の整った場所でご利用ください。")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
