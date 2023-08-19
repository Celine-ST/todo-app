//
//  MainTodoListView.swift
//  todo app
//
//  Created by Celine Quek on 5/8/23.
//

import SwiftUI

struct MainTodoListView: View {
    
    @ObservedObject var todoManager: TodoManager
    @State private var showAddSheet = false
    @State private var showConfirmAlert = false
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationStack {
            List(todoManager.todosFiltered, editActions: .all) { $todo in
                NavigationLink {
                    TodoDetailView(todo: $todo)
                } label: {
                    HStack {
                        Image(systemName: (todo.isCompleted == true ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(todo.color)
                            .onTapGesture {
                                todo.isCompleted.toggle()
                            }
                        VStack(alignment: .leading) {
                            Text(todo.title)
                            if !todo.subtitle.isEmpty {
                                Text(todo.subtitle)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .strikethrough(todo.isCompleted)
                    }
                }
            }
            .searchable(text: $todoManager.searchTerm)
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup {
                    
                    #if DEBUG
                    Button {
                    showConfirmAlert = true
                    } label: {
                    Image(systemName: "list.bullet.clipboard.fill")
                    }
                    #endif
                    
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                NewTodoView(sourceArray: $todoManager.todos)
            }
            .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
                Button("Replace", role: .destructive) {
                    todoManager.loadSampleData()
                }
            }
        }
    }
}

struct MainTodoListView_Previews: PreviewProvider {
    static var previews: some View {
        MainTodoListView(todoManager: TodoManager())
    }
}
