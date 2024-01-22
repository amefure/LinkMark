//
//  AppThemaColor.swift
//  LinkMark
//
//  Created by t&a on 2024/01/11.
//

import UIKit
import SwiftUI

enum AppThemaColor: String, CaseIterable {
    case red
    case yellow
    case green
    case blue
    case purple
    
    static func getColor(_ value: String) -> Color {
        return switch value {
        case "red":
                .exRed
        case "yellow":
                .exYellow
        case "green":
                .exGreen
        case "blue":
                .exBlue
        case "purple":
                .exPurple
        default:
                .exRed
        }
    }
    
    var name: String {
        return switch self {
        case .red:
            "ローズピンク"
        case .yellow:
            "ライトイエロー"
        case .green:
            "ミントグリーン"
        case .blue:
            "スカイブルー"
        case .purple:
            "ラベンダー"
        }
    }
}
