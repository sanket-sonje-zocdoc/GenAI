//
//  Font+AppTextStyle.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 25/01/25.
//

import SwiftUI

extension Font {
    
    /// Returns a Calibri font with regular weight
    /// - Returns: A Font instance with Calibri regular
    static func calibriRegular(_ size: CGFloat) -> Font {
        .custom("Calibri", size: size)
    }
    
    /// Returns a Calibri font with bold weight
    /// - Returns: A Font instance with Calibri bold
    static func calibriBold(_ size: CGFloat) -> Font {
        .custom("Calibri-Bold", size: size)
    }
    
    /// Returns a Calibri font with light weight
    /// - Returns: A Font instance with Calibri light
    static func calibriLight(_ size: CGFloat) -> Font {
        .custom("Calibri-Light", size: size)
    }

    /// Returns a Calibri font with Italic weight
    /// - Returns: A Font instance with Calibri Italic
    static func calibriItalic(_ size: CGFloat) -> Font {
        .custom("Calibri-Italic", size: size)
    }

    /// Returns a Calibri font with Bold Italic weight
    /// - Returns: A Font instance with Calibri Bold Italic
    static func calibriBoldItalic(_ size: CGFloat) -> Font {
        .custom("Calibri-BoldItalic", size: size)
    }
}
