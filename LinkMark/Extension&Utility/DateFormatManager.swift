//
//  DateFormatManager.swift
//  LinkMark
//
//  Created by t&a on 2024/01/18.
//


import UIKit

class DateFormatManager {

    private let df = DateFormatter()

    init(format: String = L10n.dateFormat) {
        df.dateFormat = format
        df.locale = Locale(identifier: L10n.dateLocale)
        df.calendar = Calendar(identifier: .gregorian)
    }
    
    /// yyyy年M月d日
    public func getString(date: Date) -> String {
        return df.string(from: date)
    }
    
    /// yyyy年M月d日 Date
    public func getDate(str: String) -> Date {
        return df.date(from: str) ?? Date()
    }

}
