//
//  AppDividerTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppDividerTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testDefaultInitialization() {
        let divider = AppDivider()

        // Test default values
        let mirror = Mirror(reflecting: divider)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        XCTAssertEqual(properties["color"] as? Color, .gray.opacity(0.3))
        XCTAssertEqual(properties["height"] as? CGFloat, 1)
    }

    func testCustomInitialization() {
        let customColor = Color.blue
        let customHeight: CGFloat = 2

        let divider = AppDivider(color: customColor, height: customHeight)

        // Test custom values
        let mirror = Mirror(reflecting: divider)
        let properties = Dictionary(uniqueKeysWithValues: mirror.children.map { ($0.label!, $0.value) })

        XCTAssertEqual(properties["color"] as? Color, customColor)
        XCTAssertEqual(properties["height"] as? CGFloat, customHeight)
    }
}
