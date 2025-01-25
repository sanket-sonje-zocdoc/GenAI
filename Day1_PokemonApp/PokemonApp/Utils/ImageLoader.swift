//
//  ImageProcessor.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation
import UIKit

/// A utility class for loading and caching images
class ImageLoader {

    // MARK: - Properties

    /// Shared instance for the image loader
    static let shared = ImageLoader()

    /// Cache to store loaded images
    private let imageCache = NSCache<AnyObject, AnyObject>()

    /// Logger instance for logging operations
    private let logger = Logger.shared

    // MARK: - Initialization

    private init() {}

    // MARK: - Methods

    /// Loads an image from a URL, using cached version if available
    /// - Parameters:
    ///   - url: The URL of the image to load
    ///   - completion: Closure called with the loaded UIImage or nil if loading fails
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
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

                // Cache the loaded image
                self.imageCache.setObject(image, forKey: urlString as AnyObject)

                // Return the image on main thread
                DispatchQueue.main.async {
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
