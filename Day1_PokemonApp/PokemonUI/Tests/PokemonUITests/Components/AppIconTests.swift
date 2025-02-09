//
//  AppIconTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppIconTests: PokemonUIUnitTestCase {

    // MARK: - Tests
    
    func testDefaultInitialization() {
        let systemName = "star.fill"
        let icon = AppIcon(systemName: systemName, accessibilityID: "Test")

        XCTAssertEqual(icon.systemName, systemName)
        XCTAssertEqual(icon.color, .secondary)
        XCTAssertEqual(icon.size, 16)
        XCTAssertEqual(icon.fontWeight, .medium)
    }
    
    func testCustomInitialization() {
        let systemName = "heart.fill"
        let color = Color.red
        let size: CGFloat = 32
        let fontWeight = Font.Weight.bold
        
        let icon = AppIcon(
            systemName: systemName,
            color: color,
            size: size,
            fontWeight: fontWeight,
            accessibilityID: "Test"
        )
        
        XCTAssertEqual(icon.systemName, systemName)
        XCTAssertEqual(icon.color, color)
        XCTAssertEqual(icon.size, size)
        XCTAssertEqual(icon.fontWeight, fontWeight)
    }
} 
