//
//  AppStyle.TextTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppStyleTextTests: PokemonUIUnitTestCase {

    // MARK: - Tests
    
    func testTitleStyle() {
        let style = AppStyle.Text.title
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testHeadlineStyle() {
        let style = AppStyle.Text.headline
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testBodyStyle() {
        let style = AppStyle.Text.body
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testCaptionStyle() {
        let style = AppStyle.Text.caption
        XCTAssertEqual(style.color, .white)
    }
} 
