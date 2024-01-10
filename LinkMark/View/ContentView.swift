//
//  ContentView.swift
//  LinkMark
//
//  Created by t&a on 2024/01/04.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var items: Array<Locator> = []

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }.onAppear {
            items = CoreDataRepository.fetch()
        }
    }

    private func addItem() {
        withAnimation {
            let locator: Locator = CoreDataRepository.entity()
            locator.id = UUID()
            locator.title = ""
            locator.url = URL(string: "https://tech.amefure.com/")
            locator.memo = ""
            locator.createdAt = Date()

            CoreDataRepository.insert(locator)
            CoreDataRepository.save()
        }
    }
    
}

#Preview {
    ContentView()
}
