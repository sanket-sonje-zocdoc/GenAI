//
//  SearchSortingHeaderViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class SearchSortingHeaderViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        // Open sorting view
        app.buttons["arrow.up.arrow.down"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        XCTAssertTrue(app.staticTexts["Sort Options"].exists, "Header title should exist")
        XCTAssertTrue(app.images["plus.circle"].exists, "Add criteria button should exist")
    }

    func testAddCriteriaMenu() throws {
        // Open add criteria menu
        app.images["plus.circle"].tap()

        // Verify menu sections exist
        XCTAssertTrue(app.buttons["Name"].exists, "Basic options should be available")
        XCTAssertTrue(app.buttons["HP"].exists, "Stat options should be available")

        // Add a criteria
        app.buttons["Name"].tap()

        // Verify option is removed from menu
        app.images["plus.circle"].tap()
        XCTAssertFalse(app.buttons["Name"].exists, "Used option should be removed from menu")
    }
}
