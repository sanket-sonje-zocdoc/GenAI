//
//  AppTagTests.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import XCTest

@testable import PokemonUI

@MainActor
final class AppTagTests: PokemonUIUnitTestCase {

    // MARK: - Tests

    func testInitialization() {
        let text = "Test Tag"
        let color = Color.red
        let tag = AppTag(text: text, color: color)

        XCTAssertEqual(tag.text, text)
        XCTAssertEqual(tag.color, color)
    }
}
