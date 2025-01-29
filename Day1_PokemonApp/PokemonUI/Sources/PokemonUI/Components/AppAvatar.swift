//
//  AppAvatar.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import UIKit

/// A reusable circular avatar component that displays images with a loading state.
///
/// `AppAvatar` is designed to show circular images with a consistent style across the app.
/// It handles loading states, displays a progress indicator while loading, and automatically
/// formats the image into a circular shape with a border.
///
/// Example usage:
/// ```
/// // Basic usage with default size
/// AppAvatar(url: pokemonImageURL)
///
/// // Custom size
/// AppAvatar(size: 100, url: pokemonImageURL)
///
/// // Custom styling
/// AppAvatar(
///     size: 60,
///     url: pokemonImageURL,
///     lineWidth: 2,
///     strokeColor: .blue,
///     backgroundColor: .white
/// )
///
/// // Placeholder without URL
/// AppAvatar(size: 60)
/// ```
///
/// - Important: The component automatically handles image loading and caching through `ImageLoader`.
///
/// - Note: When no image URL is provided or while the image is loading, the component
///         displays a progress indicator centered in the frame.
@available(iOS 15.0, *)
public struct AppAvatar: View {

    // MARK: - Properties

    /// The URL of the image to be loaded and displayed.
    /// If nil, the avatar will show a loading indicator indefinitely.
    public let url: URL?

    /// The width and height of the avatar in points.
    /// Defaults to the standard avatar size defined in `AppStyle.Dimensions.avatarSize`
    public let size: CGFloat

    /// The width of the border stroke around the avatar.
    /// Defaults to 1 point.
    public let lineWidth: CGFloat

    /// The color of the border stroke around the avatar.
    /// Defaults to `AppStyle.Colors.shadowColor`.
    public let strokeColor: Color

    /// The background color shown behind the image or loading indicator.
    /// Defaults to `AppStyle.Colors.surfaceBackground`.
    public let backgroundColor: Color

    /// The loaded image to be displayed.
    /// This is managed internally and updated when the image loads successfully.
    @State private var image: UIImage?

    // MARK: - Initialization

    /// Creates a new avatar with the specified size, image URL, and styling options.
    ///
    /// - Parameters:
    ///   - url:
    ///     - The URL of the image to be displayed.
    ///     - If nil, shows a loading indicator.
    ///   - size:
    ///     - The width and height of the avatar in points.
    ///     - Defaults to `AppStyle.Dimensions.avatarSize`
    ///   - lineWidth:
    ///     - The width of the border stroke around the avatar.
    ///     - Defaults to 1 point.
    ///   - strokeColor:
    ///     - The color of the border stroke around the avatar.
    ///     - Defaults to `AppStyle.Colors.shadowColor`.
    ///   - backgroundColor:
    ///     - The background color shown behind the image or loading indicator.
    ///     - Defaults to `AppStyle.Colors.surfaceBackground`.
    public init(
        url: URL? = nil,
        size: CGFloat = AppStyle.Dimensions.avatarSize,
        lineWidth: CGFloat = 1,
        strokeColor: Color = AppStyle.Colors.shadow,
        backgroundColor: Color = AppStyle.Colors.surfaceBackground
    ) {
        self.size = size
        self.url = url
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
        }
        .frame(
            width: size,
            height: size
        )
        .background(backgroundColor)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(
                    strokeColor,
                    lineWidth: lineWidth
                )
        )
        .onAppear {
            if let url = url {
                ImageLoader.shared.loadImage(from: url) { image in
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
#Preview {
    VStack(spacing: 20) {
        AppAvatar()
        AppAvatar(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"))
        AppAvatar(size: 100)
        AppAvatar(lineWidth: 5)
        AppAvatar(strokeColor: AppStyle.Colors.primaryBackground)
        AppAvatar(backgroundColor: AppStyle.Colors.primaryBackground)
    }
    .padding()
}
