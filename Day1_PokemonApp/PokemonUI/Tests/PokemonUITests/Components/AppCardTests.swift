//
//  AppCardTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppCardTests: PokemonUIUnitTestCase {

    // MARK: - Tests
    
    func testDefaultInitialization() {
        let card = AppCard {
            Text("Test Content")
        }
        
        // Test default values
        let mirror = Mirror(reflecting: card)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })
        
        XCTAssertEqual(properties["style"] as? AppCardStyle, .flat)
        XCTAssertEqual(properties["cornerRadius"] as? CGFloat, AppStyle.Radius.corner)
        XCTAssertEqual(properties["padding"] as? CGFloat, AppStyle.Padding.xSmall)
        XCTAssertEqual(properties["showBorder"] as? Bool, true)
    }

    func testCustomInitialization() {
        let card = AppCard(
            style: .elevated,
            cornerRadius: 20,
            padding: 24,
            showBorder: false
        ) {
            Text("Test Content")
        }
        
        // Test custom values
        let mirror = Mirror(reflecting: card)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })
        
        XCTAssertEqual(properties["style"] as? AppCardStyle, .elevated)
        XCTAssertEqual(properties["cornerRadius"] as? CGFloat, 20)
        XCTAssertEqual(properties["padding"] as? CGFloat, 24)
        XCTAssertEqual(properties["showBorder"] as? Bool, false)
    }
} 
