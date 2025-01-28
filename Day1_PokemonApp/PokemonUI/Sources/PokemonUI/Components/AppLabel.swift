import SwiftUI

/// A styled label component that combines an icon and text.
public struct AppLabel: View {
    // MARK: - Properties

    private let title: String
    private let systemImage: String
    private let style: AppTextStyle

    // MARK: - Initialization

    /// Creates a new AppLabel with the specified title and system image.
    /// - Parameters:
    ///   - title: The text to display in the label
    ///   - systemImage: The name of the SF Symbol to use as the icon
    ///   - style: The text style to apply to the label (default: .body)
    public init(_ title: String, style: AppTextStyle = .body, systemImage: String) {
        self.title = title
        self.style = style
        self.systemImage = systemImage
    }

    // MARK: - Body

    public var body: some View {
        Label {
            AppText(title, style: style)
        } icon: {
            AppIcon(
                systemName: systemImage,
                color: style.color
            )
        }
        .font(style.font)
        .foregroundColor(style.color)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        AppLabel("Search by Name", systemImage: "magnifyingglass")
        AppLabel("Filter Results", systemImage: "line.3.horizontal.decrease.circle")
        AppLabel("Sort Items", systemImage: "arrow.up.arrow.down")
    }
    .padding()
}
