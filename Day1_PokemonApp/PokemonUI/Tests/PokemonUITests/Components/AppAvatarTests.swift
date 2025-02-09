//
//  AppAvatarTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppAvatarTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testDefaultInitialization() {
        let avatar = AppAvatar(accessibilityID: "Test")

        XCTAssertNil(avatar.url)
        XCTAssertEqual(avatar.size, AppStyle.Dimensions.avatarSize)
        XCTAssertEqual(avatar.lineWidth, 1)
        XCTAssertEqual(avatar.strokeColor, AppStyle.Colors.shadow)
        XCTAssertEqual(avatar.backgroundColor, AppStyle.Colors.surfaceBackground)
    }

    func testCustomInitialization() {
        let url = URL(string: "https://example.com/image.png")!
        let size: CGFloat = 100
        let lineWidth: CGFloat = 2
        let strokeColor = Color.red
        let backgroundColor = Color.blue

        let avatar = AppAvatar(
            url: url,
            size: size,
            lineWidth: lineWidth,
            strokeColor: strokeColor,
            backgroundColor: backgroundColor,
            accessibilityID: "Test"
        )

        XCTAssertEqual(avatar.url, url)
        XCTAssertEqual(avatar.size, size)
        XCTAssertEqual(avatar.lineWidth, lineWidth)
        XCTAssertEqual(avatar.strokeColor, strokeColor)
        XCTAssertEqual(avatar.backgroundColor, backgroundColor)
    }
} 
