import XCTest
import SwiftUI
@testable import PokemonUI

@MainActor
final class AppAvatarTests: XCTestCase {

    // MARK: - Tests

    func testDefaultInitialization() {
        let avatar = AppAvatar()
        
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
            backgroundColor: backgroundColor
        )
        
        XCTAssertEqual(avatar.url, url)
        XCTAssertEqual(avatar.size, size)
        XCTAssertEqual(avatar.lineWidth, lineWidth)
        XCTAssertEqual(avatar.strokeColor, strokeColor)
        XCTAssertEqual(avatar.backgroundColor, backgroundColor)
    }
} 
