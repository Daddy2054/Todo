//
//  TodoApp.swift
//  Todo
//
//  Created by Jean on 09/11/24.
//
import SwiftUI

@main
struct TodoApp: App {
    
    let provider = CoreDataProvider()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(\.managedObjectContext, provider.viewContext)
            }
        }
    }
}
