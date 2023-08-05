//
//  Todo.swift
//  todo app
//
//  Created by Celine Quek on 29/7/23.
//

import Foundation
import SwiftUI

struct Todo: Identifiable, Codable {
    var id = UUID()
    var title: String
    var subtitle = ""
    var color: Color = .black
    var isCompleted = false
}

extension Color: Codable {
    // Custom coding keys enumeration (if needed)
    private enum ColorCodingKeys: String, CodingKey {
        case red, green, blue, opacity
    }
    
    // Encode the Color to a JSON representation
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ColorCodingKeys.self)
        
        // Extract RGB components and opacity
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Encode the components
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .opacity)
    }
    
    // Initialize the Color from a JSON representation
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ColorCodingKeys.self)
        
        // Decode the components
        let red = try container.decode(CGFloat.self, forKey: .red)
        let green = try container.decode(CGFloat.self, forKey: .green)
        let blue = try container.decode(CGFloat.self, forKey: .blue)
        let alpha = try container.decode(CGFloat.self, forKey: .opacity)
        
        // Create the Color
        self.init(
            red: Double(red),
            green: Double(green),
            blue: Double(blue),
            opacity: Double(alpha)
        )
    }
}
