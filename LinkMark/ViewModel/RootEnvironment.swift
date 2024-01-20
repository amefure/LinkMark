//
//  RootViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import SwiftUI
import Combine

/// アプリ内で共通で利用される状態や環境値を保持する
class RootEnvironment: ObservableObject {
    
    static let shared = RootEnvironment()
    
    @Published var navigatePath: [ScreenPath] = []
    
    @Published private(set) var editSortMode: EditMode = .inactive
    
    public func activeEditMode() {
        editSortMode = .active
    }
    
    public func inActiveEditMode() {
        editSortMode = .inactive
    }
    
    public func onAppear() {
        print("")
        navigatePath = []
    }
}





