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
        app.buttons["SortingOptions_AppIcon_Image"].tap()
    }

    // MARK: - Tests

    func testInitialState() throws {
        XCTAssertTrue(app.staticTexts["SortOptions_AppText_Text"].exists, "Header title should exist")
        XCTAssertTrue(app.images["AddSortingOption_AppIcon_Image"].exists, "Add criteria button should exist")
    }

    func testAddCriteriaMenu() throws {
        // Open add criteria menu
        app.images["AddSortingOption_AppIcon_Image"].tap()

        // Verify menu sections exist
        XCTAssertTrue(app.buttons["Name"].exists, "Basic options should be available")
        XCTAssertTrue(app.buttons["HP"].exists, "Stat options should be available")

        // Add a criteria
        app.buttons["Name"].tap()

        // Verify option is removed from menu
        app.images["AddSortingOption_AppIcon_Image"].tap()
        XCTAssertFalse(app.buttons["Name"].exists, "Used option should be removed from menu")
    }
}
