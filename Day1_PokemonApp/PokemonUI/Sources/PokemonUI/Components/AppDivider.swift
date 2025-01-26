//
//  AppDivider.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

/// A custom divider component that provides consistent styling across the app
public struct AppDivider: View {
    
    // MARK: - Properties
    
    private let color: Color
    private let height: CGFloat
    
    // MARK: - Initialization
    
    /// Creates a new AppDivider instance
    /// - Parameters:
    ///   - color: The color of the divider (defaults to gray)
    ///   - height: The height/thickness of the divider (defaults to 1 point)
    public init(
        color: Color = .gray.opacity(0.3),
        height: CGFloat = 1
    ) {
        self.color = color
        self.height = height
    }
    
    // MARK: - Body
    
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
    }
}

#Preview {
    VStack(spacing: 20) {
        AppDivider()
        
        AppDivider(color: .blue)
        
        AppDivider(height: 2)
    }
    .padding()
} 
