//
//  RootViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import SwiftUI
import Combine

class RootViewModel: ObservableObject {
    
    static let shared = RootViewModel()
    
    @Published var navigatePath: [ScreenPath] = []
    
    @Published private(set) var editSortMode: EditMode = .inactive
    
    public func activeEditMode() {
        editSortMode = .active
    }
    
    public func inActiveEditMode() {
        editSortMode = .inactive
    }
}





