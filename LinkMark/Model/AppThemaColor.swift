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
    
    public var color: Color {
        return switch self {
        case .red:
                .exRed
        case .yellow:
                .exYellow
        case .green:
                .exGreen
        case .blue:
                .exBlue
        case .purple:
                .exPurple
        }
    }
    
    public var name: String {
        return switch self {
        case .red:
            L10n.appThemaColorRed
        case .yellow:
            L10n.appThemaColorYellow
        case .green:
            L10n.appThemaColorGreen
        case .blue:
            L10n.appThemaColorBlue
        case .purple:
            L10n.appThemaColorPurple
        }
    }
}
