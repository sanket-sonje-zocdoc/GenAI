import XCTest
import SwiftUI
@testable import PokemonUI

@MainActor
final class AppTextStyleTests: XCTestCase {

    // MARK: - Tests
    
    func testTitleStyle() {
        let style = AppTextStyle.title
        XCTAssertEqual(style.color, Theme.Colors.primaryText)
    }
    
    func testHeadlineStyle() {
        let style = AppTextStyle.headline
        XCTAssertEqual(style.color, Theme.Colors.primaryText)
    }
    
    func testBodyStyle() {
        let style = AppTextStyle.body
        XCTAssertEqual(style.color, Theme.Colors.primaryText)
    }
    
    func testCaptionStyle() {
        let style = AppTextStyle.caption
        XCTAssertEqual(style.color, .white)
    }
} 
