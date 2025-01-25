//
//  ImageError.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

/// Errors that can occur during image processing operations
enum ImageError: Error {

    /// Indicates that the image could not be loaded or is invalid
    case invalidImage

    /// Indicates that the pixel data processing failed
    case processingFailed
}
