import SwiftUI

/// A reusable icon component that provides consistent styling across the application.
///
/// `AppIcon` wraps SwiftUI's `Image` view with system SF Symbols, providing standardized
/// sizing, coloring, and weight configurations. This component ensures visual consistency
/// throughout the application.
///
/// Example usage:
/// ```
/// // Basic usage with default styling
/// AppIcon(systemName: "star.fill")
///
/// // Custom colored icon
/// AppIcon(systemName: "heart.fill", color: .red)
///
/// // Custom sized icon
/// AppIcon(systemName: "bell.fill", size: 24)
/// ```
struct AppIcon: View {

    // MARK: - Properties

    /// The SF Symbols name for the icon
    let systemName: String
    
    /// The color of the icon. Defaults to the secondary text color from AppStyle
    var color: Color
    
    /// The size of the icon in points. Defaults to the standard icon size from AppStyle
    var size: CGFloat
    
    /// The font weight of the icon. Defaults to .medium
    var fontWeight: Font.Weight

    // MARK: - Initialization

    /// Creates a new icon with the specified configuration
    /// - Parameters:
    ///   - systemName: The name of the SF Symbol to display
    ///   - color: The color of the icon. Defaults to AppStyle.Colors.textSecondary
    ///   - size: The size of the icon in points. Defaults to AppStyle.Dimensions.iconSize
    ///   - fontWeight: The font weight of the icon. Defaults to .medium
    init(
        systemName: String,
        color: Color = .secondary,
        size: CGFloat = 20,
        fontWeight: Font.Weight = .medium
    ) {
        self.systemName = systemName
        self.color = color
        self.size = size
        self.fontWeight = fontWeight
    }

    // MARK: - Body

    var body: some View {
        Image(systemName: systemName)
            .foregroundColor(color)
            .font(.system(size: size, weight: fontWeight))
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            AppIcon(systemName: "star.fill")
            AppIcon(systemName: "heart.fill", color: .red)
            AppIcon(systemName: "bell.fill", size: 24)
        }
        
        HStack(spacing: 20) {
            AppIcon(systemName: "person.fill", color: .blue, size: 32)
            AppIcon(systemName: "gear", color: .gray)
            AppIcon(systemName: "bookmark.fill", fontWeight: .bold)
        }
    }
    .padding()
}
