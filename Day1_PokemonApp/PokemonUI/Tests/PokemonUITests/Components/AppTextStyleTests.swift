//
//  AppTextStyleTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppTextStyleTests: XCTestCase {

    // MARK: - Tests
    
    func testTitleStyle() {
        let style = AppTextStyle.title
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testHeadlineStyle() {
        let style = AppTextStyle.headline
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testBodyStyle() {
        let style = AppTextStyle.body
        XCTAssertEqual(style.color, AppTheme.Colors.primaryText)
    }
    
    func testCaptionStyle() {
        let style = AppTextStyle.caption
        XCTAssertEqual(style.color, .white)
    }
} 
