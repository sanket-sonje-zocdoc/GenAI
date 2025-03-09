//
//  AppProgressView.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 09/03/25.
//

import SwiftUI

/// A custom progress view component that provides a consistent loading indicator across the app.
///
/// This component wraps SwiftUI's `ProgressView` with predefined styling and accessibility support.
/// Key features include:
/// - Customizable tint color
/// - Built-in accessibility support
/// - Consistent styling across the app
///
/// This component supports both determinate and indeterminate progress states.
public struct AppProgressView: View {

    // MARK: - Properties

    /// The color used to tint the progress indicator
    private let tint: Color

    // MARK: - Initialization

    /// Creates an indeterminate progress view for loading states
    /// - Parameters:
    ///   - tint: The color used to tint the progress indicator. Defaults to the app's primary loader color.
    public init(
        tint: Color = AppStyle.LoaderColors.primary
    ) {
        self.tint = tint
    }

    // MARK: - Body

    public var body: some View {
        HStack {
            ProgressView()
                .tint(tint)
            .a11yID("ProgressView", view: .appProgressView, component: .progressView)
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 30) {
        AppProgressView()
    }
    .padding()
}
