import SwiftUI

/// A utility enum that handles custom font registration for the application.
/// This component manages the registration of custom fonts from the app's bundle
/// to make them available for use throughout the application.
public enum AppFonts {

    /// Registers all custom fonts found in the application bundle's Resources/Fonts directory.
    /// This method should be called early in the application lifecycle, typically at launch,
    /// to ensure all custom fonts are available for use.
    ///
    /// The method performs the following steps:
    /// 1. Locates the Resources folder in the module bundle
    /// 2. Finds all font files in the Fonts subdirectory
    /// 3. Registers each font with the system using Core Text
    ///
    /// - Note: If registration fails for any font, an error message will be printed to the console
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
