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
        let style: AppTextStyle = .title

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
        XCTAssertEqual(label.style.font, AppTextStyle.body.font)
        XCTAssertEqual(label.style.color, AppTextStyle.body.color)
    }

    func testAppLabelBody() throws {
        // Given
        let title = "Test Label"
        let systemImage = "star"
        let style: AppTextStyle = .title

        // When
        let label = AppLabel(title, style: style, systemImage: systemImage)

        // Then
        let labelView = label.body
        XCTAssertNotNil(labelView)
        
        let mirror = Mirror(reflecting: labelView)
        let labelContent = try XCTUnwrap(findView(in: mirror) as Label<AppText, AppIcon>?)
        XCTAssertNotNil(labelContent)
        
        // Verify the title matches
        let labelMirror = Mirror(reflecting: labelContent)
        XCTAssertTrue(labelMirror.children.contains { child in
            if let appText = child.value as? AppText {
                return appText.text == title
            }
            return false
        })
    }
}
