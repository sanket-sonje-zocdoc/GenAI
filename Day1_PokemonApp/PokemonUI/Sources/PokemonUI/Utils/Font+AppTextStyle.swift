//
//  Font+AppTextStyle.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

///  Extension providing convenient access to Calibri font variants
///  for use within the Pokemon app's UI components.
@available(iOS 18.0, *)
extension Font {

    /// Returns a Calibri font with regular weight
    /// - Parameter size: The point size of the font
    /// - Returns: A Font instance configured with Calibri regular at the specified size
    public static func calibriRegular(_ size: CGFloat) -> Font {
        .custom("Calibri", size: size)
    }

    /// Returns a Calibri font with bold weight
    /// - Parameter size: The point size of the font
    /// - Returns: A Font instance configured with Calibri bold at the specified size
    public static func calibriBold(_ size: CGFloat) -> Font {
        .custom("Calibri-Bold", size: size)
    }

    /// Returns a Calibri font with light weight
    /// - Parameter size: The point size of the font
    /// - Returns: A Font instance configured with Calibri light at the specified size
    public static func calibriLight(_ size: CGFloat) -> Font {
        .custom("Calibri-Light", size: size)
    }

    /// Returns a Calibri font with italic style
    /// - Parameter size: The point size of the font
    /// - Returns: A Font instance configured with Calibri italic at the specified size
    public static func calibriItalic(_ size: CGFloat) -> Font {
        .custom("Calibri-Italic", size: size)
    }

    /// Returns a Calibri font with bold italic style
    /// - Parameter size: The point size of the font
    /// - Returns: A Font instance configured with Calibri bold italic at the specified size
    public static func calibriBoldItalic(_ size: CGFloat) -> Font {
        .custom("Calibri-BoldItalic", size: size)
    }
}
