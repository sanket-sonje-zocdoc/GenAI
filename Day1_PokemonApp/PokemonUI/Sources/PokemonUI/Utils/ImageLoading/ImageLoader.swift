//
//  ImageProcessor.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation
import UIKit

import PokemonUtils

/// A utility class responsible for loading and caching images from URLs.
/// This class provides efficient image loading with an in-memory caching mechanism
/// to prevent redundant network requests.
///
/// Usage Example:
/// ```
/// let imageLoader = ImageLoader.shared
/// imageLoader.loadImage(from: imageURL) { image in
///     if let image = image {
///         // Use the loaded image
///     }
/// }
/// ```
@MainActor
public class ImageLoader {

    // MARK: - Properties

    /// Shared instance for the image loader
    public static let shared = ImageLoader()

    /// Logger instance for logging operations
    private let logger = Logger.shared

    /// Cache to store loaded images
    @MainActor var imageCache = NSCache<AnyObject, AnyObject>()

    // MARK: - Initialization

    private init() {}

    // MARK: - Methods

    /// Loads an image from a URL, using cached version if available.
    /// This method first checks the in-memory cache for the image. If not found,
    /// it downloads the image from the provided URL in a background thread.
    ///
    /// - Parameters:
    ///   - url: The URL of the image to load
    ///   - completion: A closure that will be called on the main thread with the loaded image
    ///                 The closure receives a UIImage if successful, or nil if loading fails
    ///
    /// - Note: The completion handler is always called on the main thread
    /// - Important: This method uses a background queue for network operations to avoid blocking the main thread
    public func loadImage(from url: URL, completion: @escaping @Sendable (UIImage?) -> Void) {
        let urlString = url.absoluteString

        // Check if image is already cached
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(cachedImage)
            return
        }

        // Load image from URL in background
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else {
                self?.logger.log("Self was deallocated", level: .error)
                completion(nil)
                return
            }

            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    self.logger.log("Failed to create UIImage from data", level: .error)
                    completion(nil)
                    return
                }

                // Cache the loaded image on main thread
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: urlString as AnyObject)
                    completion(image)
                }
            } catch {
                self.logger.log("Failed to load image: \(error.localizedDescription)", level: .error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
