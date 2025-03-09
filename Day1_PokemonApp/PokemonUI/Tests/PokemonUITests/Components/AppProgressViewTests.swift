//
//  AppProgressViewTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/03/25.
//

import SwiftUI
import XCTest
@testable import PokemonUI

@MainActor
final class AppProgressViewTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testDefaultInitialization() {
        let progressView = AppProgressView()

        // Test default values using Mirror
        let mirror = Mirror(reflecting: progressView)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        // Verify default tint color
        XCTAssertEqual(properties["tint"] as? Color, AppStyle.LoaderColors.primary)
    }

    func testCustomInitialization() {
        let customTint = Color.red
        let progressView = AppProgressView(
            tint: customTint
        )

        // Test custom values
        let mirror = Mirror(reflecting: progressView)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        XCTAssertEqual(properties["tint"] as? Color, customTint)
    }
}
