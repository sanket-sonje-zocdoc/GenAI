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
final class AppCardTests: XCTestCase {

    // MARK: - Tests
    
    func testContentInitialization() {
        let testText = "Test Content"
        let card = AppCard {
            Text(testText)
        }
        
        // Verify content is initialized
        let mirror = Mirror(reflecting: card)
        let contentProperty = mirror.children.first { $0.label == "content" }
        XCTAssertNotNil(contentProperty)
    }
} 
