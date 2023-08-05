//
//  ContentView.swift
//  todo app
//
//  Created by Celine Quek on 29/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var todoManager = TodoManager()
    @State private var showAddSheet = false
    var body: some View {
        NavigationStack {
            List($todoManager.todos, editActions: .all) { $todo in
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
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
