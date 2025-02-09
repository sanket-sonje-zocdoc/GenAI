//
//  PokemonDetailViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonDetailViewTests: PokemonBaseViewTests {

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Navigate to a Pokemon detail view
        app.collectionViews.cells.firstMatch.tap()
    }

    // MARK: - Tests

    func testDetailViewElements() throws {
        // Verify navigation title
        XCTAssertTrue(app.navigationBars["Pokemon Details"].exists)

        // Verify Pokemon image exists
        XCTAssertTrue(app.images.firstMatch.exists)

        // Verify Pokemon name is displayed
        let pokemonName = app.staticTexts.element(matching: .any, identifier: nil).firstMatch
        XCTAssertTrue(pokemonName.exists)

        // Verify type tags exist
        XCTAssertTrue(app.staticTexts["BaseStats_AppText_Text"].exists)
    }

    func testStatsDisplay() throws {
        // Verify all stat categories are displayed
        let expectedStats = ["Hp", "Attack", "Defense", "Special-Attack", "Special-Defense", "Speed"]

        for stat in expectedStats {
            XCTAssertTrue(app.staticTexts["\(stat)_AppText_Text"].exists, "\(stat) should be visible")

            // Verify progress bars exist
            let progressBar = app.otherElements["\(stat)_AppProgressBar_ProgressView"]
            XCTAssertTrue(progressBar.exists)
        }
    }
}
