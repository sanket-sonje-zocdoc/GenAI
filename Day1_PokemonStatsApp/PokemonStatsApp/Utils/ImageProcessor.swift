//
//  ImageProcessor.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//


import Foundation
import UIKit

/// A utility class for processing image data and performing RGB calculations
class ImageProcessor {

    // MARK: - Methods

    /// Logger instance for image processing operations
    private static let logger = Logger.shared

    /// Calculates the sum of RGB values for all pixels in an image from a given URL
    /// - Parameter urlString: The URL string of the image to process
    /// - Returns: The sum of all RGB values in the image
    /// - Throws: `ImageError.invalidImage` if the image cannot be loaded or is invalid
    ///          `ImageError.processingFailed` if pixel data processing fails
    static func calculateRGBSum(from urlString: String) async throws -> Int {
        guard let url = URL(string: urlString),
              let (data, _) = try? await URLSession.shared.data(from: url),
              let uiImage = UIImage(data: data),
              let cgImage = uiImage.cgImage else {
            logger.log("Failed to load or process image from URL: \(urlString)", level: .error)
            throw ImageError.invalidImage
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let bitsPerComponent = 8
        
        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ),
        let pixelData = context.data else {
            logger.log("Failed to create graphics context or get pixel data", level: .error)
            throw ImageError.processingFailed
        }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let pixels = pixelData.bindMemory(
            to: UInt8.self,
            capacity: width * height * bytesPerPixel
        )
        
        var rgbSum = 0
        
        // Simply add raw R, G, and B values for each pixel
        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * bytesPerRow) + (x * bytesPerPixel)
                rgbSum += Int(pixels[offset])     // R
                rgbSum += Int(pixels[offset + 1]) // G
                rgbSum += Int(pixels[offset + 2]) // B
            }
        }
        
        logger.log("Successfully calculated RGB sum: \(rgbSum)", level: .debug)
        return rgbSum
    }
}
