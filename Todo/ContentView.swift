//
//  ContentView.swift
//  Todo
//
//  Created by Jean on 09/11/24.
//


import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var title: String = ""
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    private func saveTodoItem() {
        let todoItem = TodoItem(context: context)
        todoItem.title = title
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if isFormValid {
                            saveTodoItem()
                            title = ""
                        }
                    }
            
            Spacer()

        }
        .padding()
        .navigationTitle("Todo")
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
