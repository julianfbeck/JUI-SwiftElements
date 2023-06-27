//
//  File.swift
//  
//
//  Created by Julian Beck on 27.06.23.
//

import SwiftUI

public struct CustomImageViewModifier: ViewModifier {
    
    var size: CGFloat = 22
    var color: Color
    
    public func body(content: Content) -> some View {
        content
            .imageScale(.small)
            .font(.system(size: 15))
            .frame(width: size, height: size, alignment: .center)
            .foregroundColor(color) // SF Symbol color
            .font(.headline)
            .padding(3)
            .background(color.opacity(0.3)) // Background color with 30% opacity
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) // Rounded rectangle
    }
}

extension View {
    func roundedColoredSfSymbol(size: CGFloat, color: Color) -> some View {
        self.modifier(CustomImageViewModifier(size: size, color: color))
    }
}
