//
//  AppLabelTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppLabelTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testAppLabelInitialization() {
        // Given
        let title = "Test Label"
        let systemImage = "star"
        let style: AppStyle.Text = .title

        // When
        let label = AppLabel(title, style: style, systemImage: systemImage)

        // Then
        XCTAssertEqual(label.title, title)
        XCTAssertEqual(label.systemImage, systemImage)
        XCTAssertEqual(label.style.font, style.font)
        XCTAssertEqual(label.style.color, style.color)
    }

    func testAppLabelDefaultStyle() {
        // Given
        let title = "Test Label"
        let systemImage = "star"

        // When
        let label = AppLabel(title, systemImage: systemImage)

        // Then
        XCTAssertEqual(label.style.font, AppStyle.Text.body.font)
        XCTAssertEqual(label.style.color, AppStyle.Text.body.color)
    }

    func testAppLabelBody() throws {
        // Given
        let title = "Test Label"
        let systemImage = "star"
        let style: AppStyle.Text = .title

        // When
        let label = AppLabel(title, style: style, systemImage: systemImage)

        // Then
        let labelView = label.body
        XCTAssertNotNil(labelView)

        let mirror = Mirror(reflecting: labelView)

        // Verify the title matches
        let appText = try XCTUnwrap(findView(in: mirror) as AppText?)
        XCTAssertEqual(appText.text, title)

        // Verify the icon matches
        let appIcon = try XCTUnwrap(findView(in: mirror) as AppIcon?)
        XCTAssertEqual(appIcon.systemName, systemImage)
    }
}
