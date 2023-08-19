//
//  NewTodoView.swift
//  todo app
//
//  Created by Celine Quek on 5/8/23.
//

import SwiftUI

struct NewTodoView: View {

    @State private var todoTitle = ""
    @State private var todoSubtitle = ""
    @State private var todoColor: Color = .black
    @Binding var sourceArray: [Todo]
    @Environment(\.dismiss) var dismiss
    
    @State private var whitespaceChecker = ""
    @State private var showAlert = false
    var body: some View {
        Form {
            Section("Info") {
                TextField("Title", text: $todoTitle)
                TextField("Subtitle", text: $todoSubtitle)
                ColorPicker("Todo Colour", selection: $todoColor)
            }
            Section("Actions") {
                Button("Save") {
                    whitespaceChecker = todoTitle.replacingOccurrences(of: " ", with: "")
                    
                    if !whitespaceChecker.isEmpty {
                        let todo = Todo(title: todoTitle, subtitle: todoSubtitle)
                        sourceArray.append(todo)
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }
                .alert("Please input a title", isPresented: $showAlert) {}
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}
struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView(sourceArray: .constant([]))
    }
}
