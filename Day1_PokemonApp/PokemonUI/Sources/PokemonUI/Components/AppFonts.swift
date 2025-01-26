import SwiftUI

/// A utility enum that provides custom font management functionality for the application.
/// This component is responsible for registering custom fonts from the bundle's resources,
/// making them available throughout the application's lifecycle.
///
/// Usage:
/// ```swift
/// // Call this during app initialization
/// AppFonts.register()
/// ```
public enum AppFonts {

    /// Registers all custom fonts found in the application bundle.
    /// This method should be called early in the application lifecycle, typically in the
    /// `App.init()` or `AppDelegate.didFinishLaunching`.
    ///
    /// The method automatically handles:
    /// - Scanning for font files with .ttf and .otf extensions
    /// - Registering each found font with the system
    /// - Error handling for failed registrations
    ///
    /// - Important: Font registration is a one-time operation that must occur before
    ///             any attempts to use the custom fonts in the UI.
    ///
    /// - Note: Registration failures for individual fonts will be logged to the console
    ///         but will not interrupt the registration of other fonts.
    public static func register() {
        let bundle = Bundle.module
        let fontExtensions = ["ttf", "otf"]
        
        // Get all font files directly from the bundle
        let foundFonts = fontExtensions.flatMap { ext in
            bundle.urls(forResourcesWithExtension: ext, subdirectory: nil) ?? []
        }
        
        // Register each font
        foundFonts.forEach { url in
            guard let fontDataProvider = CGDataProvider(url: url as CFURL),
                  let font = CGFont(fontDataProvider) else {
                return
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("Error registering font: \(url.lastPathComponent)")
            }
        }
    }
}
