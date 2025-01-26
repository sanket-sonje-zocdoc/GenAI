import SwiftUI

/// `AppCard` is a reusable container view component that provides consistent card-style presentation
/// for its content. It applies standard padding, background, and shadow styling to create
/// an elevated card effect.
///
/// Example usage:
/// ```swift
/// AppCard {
///     Text("Card Content")
///         .padding()
/// }
/// ```
@available(iOS 15.0, *)
public struct AppCard<Content: View>: View {

    // MARK: - Properties

    /// The content view to be displayed within the card
    public let content: Content

    /// The padding applied to the content inside the card.
    /// Defaults to xSmall padding on all sides.
    public let padding: EdgeInsets = .init(
        top: AppStyle.Padding.xSmall,
        leading: AppStyle.Padding.normal,
        bottom: AppStyle.Padding.xSmall,
        trailing: AppStyle.Padding.normal
    )

    // MARK: - Initialization

    /// Creates a new card view with the given content
    /// - Parameter content: A closure that returns the content view to be displayed within the card
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        content
            .padding(padding)
            .background(AppStyle.SharedStyles.cardBackground())
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: AppStyle.Padding.medium) {
        AppCard {
            Text("Default Card")
                .padding()
        }

        AppCard {
            VStack(alignment: .leading) {
                Text("Custom Card")
                    .font(.headline)
                Text("With multiple lines of content")
                    .font(.subheadline)
            }
            .padding()
        }
    }
    .padding()
}
