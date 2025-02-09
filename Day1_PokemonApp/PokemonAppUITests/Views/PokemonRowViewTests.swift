//
//  PokemonRowViewTests.swift
//  PokemonAppUITests
//
//  Created by Sanket Sonje on 02/02/25.
//

import XCTest

final class PokemonRowViewTests: PokemonBaseViewTests {

    // MARK: - Tests

    func testRowElements() throws {
        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Get first row
        let firstRow = app.collectionViews.cells.firstMatch
        XCTAssertTrue(firstRow.exists)

        // Verify row contains Pokemon image
        XCTAssertTrue(firstRow.images.firstMatch.exists)

        // Verify row contains Pokemon name
        XCTAssertTrue(firstRow.staticTexts.firstMatch.exists)

        // Verify chevron indicator exists
        XCTAssertTrue(firstRow.images["RightIcon_AppIcon_Image"].exists)
    }

    func testRowNavigation() throws {
        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Get first row
        let firstRow = app.collectionViews.cells.firstMatch

        // Tap row
        firstRow.tap()

        // Verify navigation to detail view
        XCTAssertTrue(app.navigationBars["Pokemon Details"].exists)
    }

    func testTypeTagsDisplay() throws {
        // Wait for list to load
        let progressView = app.progressIndicators.firstMatch
        XCTAssertTrue(progressView.waitForNonExistence(timeout: 5))

        // Get first row
        let firstRow = app.collectionViews.cells.firstMatch

        // Verify type tags exist
        let typeTags = firstRow.staticTexts.matching(NSPredicate(format: "identifier CONTAINS[c] '_AppTag'"))
        XCTAssertGreaterThan(typeTags.count, 0)
    }
}
