//
//  AppAvatar.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI
import UIKit

import PokemonUtils

/// A reusable circular avatar component that displays images with a loading state.
///
/// `AppAvatar` is designed to show circular images with a consistent style across the app.
/// It handles loading states, displays a progress indicator while loading, and automatically
/// formats the image into a circular shape with a border.
///
/// The component uses `ImageLoader` for efficient image loading and caching, ensuring optimal
/// performance when displaying multiple avatars.
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
/// // Placeholder without URL (shows loading indicator)
/// AppAvatar(size: 60)
/// ```
///
/// - Important: The component requires iOS 15.0 or later.
///
/// - Note:
///   - When no image URL is provided or while the image is loading, the component
///     displays a progress indicator centered in the frame.
///   - The component is accessibility-friendly with proper identifiers for VoiceOver support.
///   - Images are automatically resized and cropped to fit the circular frame while maintaining
///     their aspect ratio.
@available(iOS 15.0, *)
public struct AppAvatar: View {

    // MARK: - Properties

    /// The URL of the image to be loaded and displayed.
    /// If nil, the avatar will show a loading indicator indefinitely.
    /// The URL should point to a valid image resource that can be loaded by `ImageLoader`.
    public let url: URL?

    /// The width and height of the avatar in points.
    /// Defaults to the standard avatar size defined in `AppStyle.Dimensions.avatarSize`
    public let size: CGFloat

    /// The width of the border stroke around the avatar.
    /// Defaults to 1 point.
    public let lineWidth: CGFloat

    /// The color of the border stroke around the avatar.
    /// Defaults to `AppStyle.ShadowColors.primary`.
    public let strokeColor: Color

    /// The background color shown behind the image or loading indicator.
    /// Defaults to `AppStyle.BackgroundColors.surface`.
    public let backgroundColor: Color

    /// The accessibility identifier prefix for this avatar
    public let accessibilityID: String

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
    ///     - Defaults to `AppStyle.LineWidth.xxxSmall` point.
    ///   - strokeColor:
    ///     - The color of the border stroke around the avatar.
    ///     - Defaults to `AppStyle.ShadowColors.primary`.
    ///   - backgroundColor:
    ///     - The background color shown behind the image or loading indicator.
    ///     - Defaults to `AppStyle.BackgroundColors.surface`.
    ///   - accessibilityID:
    ///     - The accessibility identifier prefix for this avatar.
    public init(
        url: URL? = nil,
        size: CGFloat = AppStyle.Dimensions.avatarSize,
        lineWidth: CGFloat = AppStyle.LineWidth.xxxSmall,
        strokeColor: Color = AppStyle.ShadowColors.primary,
        backgroundColor: Color = AppStyle.BackgroundColors.surface,
        accessibilityID: String
    ) {
        self.size = size
        self.url = url
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.backgroundColor = backgroundColor
        self.accessibilityID = accessibilityID
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .a11yID(accessibilityID, view: .appAvatar, component: .image)
            } else {
                AppProgressView()
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
        AppAvatar(accessibilityID: "Bulbasaur")
        AppAvatar(
            url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
            accessibilityID: "Bulbasaur"
        )
        AppAvatar(size: 100, accessibilityID: "Bulbasaur")
        AppAvatar(lineWidth: 5, accessibilityID: "Bulbasaur")
        AppAvatar(strokeColor: AppStyle.BackgroundColors.primary, accessibilityID: "Bulbasaur")
        AppAvatar(backgroundColor: AppStyle.BackgroundColors.primary, accessibilityID: "Bulbasaur")
    }
    .padding()
}
