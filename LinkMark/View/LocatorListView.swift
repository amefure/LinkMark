//
//  LocatorListView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/10.
//

import SwiftUI

struct LocatorListView: View {
    
    @ObservedObject private var viewModel = LocatorViewModel()
    var body: some View {
        VStack {
            Text("LINKMARK")
            List {
                ForEach(viewModel.locators) { locator in
                    NavigationLink {
                        
                    } label: {
                        
                    }
                }
            }
            
            Button {
                viewModel.fetchAllLocators(categoryId: "")
            } label: {
                Text("ADD")
            }

        }
    }
}

#Preview {
    LocatorListView()
}
