//
//  AppTextTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import Testing
import XCTest

@testable import PokemonUI

@MainActor
final class AppTextTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    @Test(
        arguments: [
            AppTextStyle.title,
            AppTextStyle.headline,
            AppTextStyle.body,
            AppTextStyle.caption,
            AppTextStyle.customRegular(
                fontSize: AppStyle.Padding.xSmall,
                color: AppTheme.Colors.background
            )
        ]
    )
    func testDefaultInitialization(style: AppTextStyle) {
        // Given
        let text = "Test Text"
        let appText = AppText(text, style: style)

        // Then
        XCTAssertEqual(appText.text, text)
        XCTAssertEqual(appText.style.font, style.font)
        XCTAssertEqual(appText.style.color, style.color)
    }

    func testCustomStyleInitialization() {
        // Given
        let text = "Test Text"
        let style = AppTextStyle.customRegular(fontSize: AppStyle.Padding.xSmall, color: AppTheme.Colors.background)
        let appText = AppText(text, style: style)

        // Then
        XCTAssertEqual(appText.text, text)
        XCTAssertEqual(appText.style.font, style.font)
        XCTAssertEqual(appText.style.color, style.color)
    }
}
