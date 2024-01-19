//
//  RootViewModel.swift
//  LinkMark
//
//  Created by t&a on 2024/01/19.
//

import SwiftUI

class RootViewModel: ObservableObject {
    
    static let shared = RootViewModel()
    
    @Published private(set) var editSortMode: EditMode = .inactive
    
    public func activeEditMode() {
        editSortMode = .active
    }
    
    public func inActiveEditMode() {
        editSortMode = .inactive
    }
}

