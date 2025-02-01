//
//  ImageLoaderTests.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 02/01/25.
//

import UIKit
import XCTest

@testable import PokemonUI

@MainActor
final class ImageLoaderTests: PokemonUIUnitTestCase {

    // MARK: - Properties

    private var imageLoader: ImageLoader!
    private var mockURL: URL!

    // MARK: - Test Lifecycle

    override func setUp() async throws {
        await MainActor.run {
            super.setUp()
        }

        imageLoader = ImageLoader.shared
        mockURL = URL(string: "https://example.com/image.png")!
    }

    override func tearDown() async throws {
        await MainActor.run {
            super.tearDown()
        }

        imageLoader.imageCache.removeAllObjects()
    }

    // MARK: - Tests

    func testImageCaching() async {
        // Create a test image
        let testImage = UIImage(systemName: "star.fill")!

        // Cache the image
        imageLoader.imageCache.setObject(testImage, forKey: mockURL.absoluteString as AnyObject)

        // Create expectation
        let expectation = XCTestExpectation(description: "Image loaded from cache")

        // Test loading cached image
        imageLoader.loadImage(from: mockURL) { image in
            XCTAssertNotNil(image)
            XCTAssertEqual(image, testImage)
            expectation.fulfill()
        }

        await wait(for: [expectation])
    }

    func testImageLoadingFailure() async throws {
        // Create invalid URL
        let invalidURL = URL(string: "https://invalid-url.com/nonexistent.jpg")!

        // Create expectation
        let expectation = XCTestExpectation(description: "Image loading should fail")

        // Test loading invalid image
        await MainActor.run {
            imageLoader.loadImage(from: invalidURL) { image in
                XCTAssertNil(image)
                expectation.fulfill()
            }
        }

        await wait(for: [expectation])
    }

    func testConcurrentImageLoading() async {
        // Create multiple mock URLs
        let urls = (1...3).map { URL(string: "https://example.com/image\($0).png")! }

        // Create expectations for each URL
        let expectations = urls.map {
            XCTestExpectation(description: "Image loaded from \($0)")
        }

        // Test loading multiple images concurrently
        for (index, url) in urls.enumerated() {
            imageLoader.loadImage(from: url) { image in
                // For this test, we expect nil since URLs are invalid
                XCTAssertNil(image)
                expectations[index].fulfill()
            }
        }

        await wait(for: expectations)
    }
}
