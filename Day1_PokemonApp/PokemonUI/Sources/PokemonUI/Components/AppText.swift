import SwiftUI

/// A reusable text component that provides consistent styling across the application
///
/// `AppText` is designed to maintain typography consistency by providing predefined
/// text styles that align with the app's design system.
///
/// Example usage:
/// ```
/// AppText("Hello World", style: .title)
/// AppText("Description", style: .body)
/// ```
@available(iOS 15.0, *)
public struct AppText: View {

    // MARK: - Properties

    /// The text content to be displayed
    public let text: String

    /// The style configuration for the text
    public let style: AppTextStyle

    // MARK: - Initialization

    /// Creates a new AppText instance
    /// - Parameters:
    ///   - text: The string content to be displayed
    ///   - style: The text style to apply (defaults to .body if not specified)
    public init(_ text: String, style: AppTextStyle = .body) {
        self.text = text
        self.style = style
    }

    // MARK: - Body

    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(style.color)
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: 16) {
        AppText("Title Style", style: .title)
        AppText("Headline Style", style: .headline)
        AppText("Body Style", style: .body)
        AppText("Caption Style", style: .caption)
            .background(.black)
    }
    .padding()
}
