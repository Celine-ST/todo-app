//
//  ContentView.swift
//  todo app
//
//  Created by Celine Quek on 29/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todos = [
        Todo(title: "Buy 20kg of Nutella"),
        Todo(title: "Call a courier for 20kg of Nutella", subtitle: "Might need a van"),
        Todo(title: "Pack 20kg of Nutella in office"),
        Todo(title: "Buy health insurance"),
        Todo(title: "Eat 20kg of Nutella"),
        Todo(title: "Regret life decisions")]
    var body: some View {
        NavigationStack {
            List($todos, editActions: [.all]) { $todo in
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
