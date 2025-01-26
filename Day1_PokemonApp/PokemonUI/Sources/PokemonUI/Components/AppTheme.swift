import SwiftUI

/// Provides theme-specific colors and styling for the application
@available(iOS 18.0, *)
public enum Theme {

    /// Colors used throughout the application
    public struct Colors {

        /// Background color for the main content
        public static let background = Color("Background")

        /// Background color for card-like elements
        public static let cardBackground = Color("CardBackground")

        /// Primary text color
        public static let primaryText = Color("PrimaryText")

        /// Secondary text color
        public static let secondaryText = Color("SecondaryText")
    }
}
