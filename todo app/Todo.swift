//
//  Todo.swift
//  todo app
//
//  Created by Celine Quek on 29/7/23.
//

import Foundation
import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var title: String
    var subtitle = ""
    var color: Color = .black
    var isCompleted = false
}
