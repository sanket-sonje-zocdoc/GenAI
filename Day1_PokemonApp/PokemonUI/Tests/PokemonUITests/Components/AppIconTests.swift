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
        let imageName = "star.fill"
        let icon = AppIcon(imageName: imageName, accessibilityID: "Test")

        XCTAssertEqual(icon.imageName, imageName)
        XCTAssertEqual(icon.color, AppStyle.TextColors.secondary)
        XCTAssertEqual(icon.size, 16)
        XCTAssertEqual(icon.fontWeight, .medium)
    }
    
    func testCustomInitialization() {
        let imageName = "heart.fill"
        let color = Color.red
        let size: CGFloat = 32
        let fontWeight = Font.Weight.bold
        
        let icon = AppIcon(
            imageName: imageName,
            color: color,
            size: size,
            fontWeight: fontWeight,
            accessibilityID: "Test"
        )
        
        XCTAssertEqual(icon.imageName, imageName)
        XCTAssertEqual(icon.color, color)
        XCTAssertEqual(icon.size, size)
        XCTAssertEqual(icon.fontWeight, fontWeight)
    }
} 
