import Foundation
import SwiftUI
import UIKit

/// Provides theme-specific colors and styling for the application
@available(iOS 15.0, *)
public enum Theme {

    /// Colors used throughout the application
    public struct Colors {

        /// Background color for the main content
        public static let background = Color("Background", bundle: .module)

        /// Background color for card-like elements
        public static let cardBackground = Color("CardBackground", bundle: .module)

        /// Primary text color
        public static let primaryText = Color("PrimaryText", bundle: .module)

        /// Secondary text color
        public static let secondaryText = Color("SecondaryText", bundle: .module)
    }
}
