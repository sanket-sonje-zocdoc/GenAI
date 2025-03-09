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
        let image = "star"
        let style: AppStyle.Text = .title
        let imageSize: CGFloat = 24

        // When
        let label = AppLabel(title, style: style, image: image, imageSize: imageSize)

        // Then
        XCTAssertEqual(label.title, title)
        XCTAssertEqual(label.image, image)
        XCTAssertEqual(label.style.font, style.font)
        XCTAssertEqual(label.style.color, style.color)
        XCTAssertEqual(label.imageSize, imageSize)
    }

    func testAppLabelDefaultStyle() {
        // Given
        let title = "Test Label"
        let image = "star"

        // When
        let label = AppLabel(title, image: image)

        // Then
        XCTAssertEqual(label.style.font, AppStyle.Text.body.font)
        XCTAssertEqual(label.style.color, AppStyle.Text.body.color)
        XCTAssertEqual(label.imageSize, AppStyle.Frame.normal.height)
    }

    func testAppLabelCustomImageSize() {
        // Given
        let title = "Test Label"
        let image = "star"
        let customSize: CGFloat = 32

        // When
        let label = AppLabel(title, image: image, imageSize: customSize)

        // Then
        XCTAssertEqual(label.imageSize, customSize)
    }

    func testAppLabelBody() throws {
        // Given
        let title = "Test Label"
        let image = "star"
        let style: AppStyle.Text = .title
        let imageSize: CGFloat = 24

        // When
        let label = AppLabel(title, style: style, image: image, imageSize: imageSize)

        // Then
        let labelView = label.body
        XCTAssertNotNil(labelView)

        let mirror = Mirror(reflecting: labelView)

        // Verify the title matches
        let appText = try XCTUnwrap(findView(in: mirror) as AppText?)
        XCTAssertEqual(appText.text, title)

        // Verify the icon matches
        let appIcon = try XCTUnwrap(findView(in: mirror) as AppIcon?)
        XCTAssertEqual(appIcon.imageName, image)
        XCTAssertEqual(appIcon.size, imageSize)
    }
}
