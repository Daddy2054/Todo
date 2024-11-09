//
//  ContentView.swift
//  Todo
//
//  Created by Jean on 09/11/24.
//



import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<TodoItem>
    
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
    
    private var pendingTodoItems: [TodoItem] {
        todoItems.filter { !$0.isCompleted }
    }
    
    private var completedTodoItems: [TodoItem] {
        todoItems.filter { $0.isCompleted }
    }
    
    private func updateTodoItem(_ todoItem: TodoItem) {
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
            
            List {
                Section("Pending") {
                    ForEach(pendingTodoItems) { todoItem in
                        TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                    }
                }
                
                Section("Completed") {
                    ForEach(completedTodoItems) { todoItem in
                        TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                    }
                }
                
            }.listStyle(.plain)
            
            Spacer()

        }
        .padding()
        .navigationTitle("Todo")
    }
}

struct TodoCellView: View {
    
    let todoItem: TodoItem
    let onChanged: (TodoItem) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square": "square")
                .onTapGesture {
                    todoItem.isCompleted = !todoItem.isCompleted
                    onChanged(todoItem)
                }
            if todoItem.isCompleted {
                Text(todoItem.title ?? "")
            } else {
                TextField("", text: Binding(get: {
                    todoItem.title ?? ""
                }, set: { newValue in
                    todoItem.title = newValue
                })).onSubmit {
                    onChanged(todoItem)
                }
            }
        }
    }
    
}



#Preview {
    NavigationStack {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
