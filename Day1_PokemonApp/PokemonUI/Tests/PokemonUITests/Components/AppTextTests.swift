//
//  AppTextTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppTextTests: XCTestCase {

    // MARK: - Tests
    
    func testDefaultInitialization() {
        let text = "Test Text"
        let appText = AppText(text)
        
        XCTAssertEqual(appText.text, text)
        XCTAssertEqual(appText.style, .body)
    }
    
    func testCustomStyleInitialization() {
        let text = "Test Text"
        let style = AppTextStyle.title
        let appText = AppText(text, style: style)
        
        XCTAssertEqual(appText.text, text)
        XCTAssertEqual(appText.style, style)
    }
} 
