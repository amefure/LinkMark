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
  /// 例：レシピ・趣味など
  internal static let categoryInputPlaceholder = L10n.tr("Localizable", "category_input_placeholder", fallback: "例：レシピ・趣味など")
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
  /// リンクタイトル
  internal static let locatorInputPlaceholderTitle = L10n.tr("Localizable", "locator_input_placeholder_title", fallback: "リンクタイトル")
  /// https://XXX.com/
  internal static let locatorInputPlaceholderUrl = L10n.tr("Localizable", "locator_input_placeholder_url", fallback: "https://XXX.com/")
  /// ・タイトルは必須入力です。
  internal static let locatorInputValidationTitle = L10n.tr("Localizable", "locator_input_validation_title", fallback: "・タイトルは必須入力です。")
  /// ・有効なリンクを入力してください。
  internal static let locatorInputValidationUrl = L10n.tr("Localizable", "locator_input_validation_url", fallback: "・有効なリンクを入力してください。")
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
