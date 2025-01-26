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
        // Get the bundle that contains the font files
        guard let bundleURL = Bundle.module.url(forResource: "Resources", withExtension: nil) else {
            print("Could not find Resources folder")
            return
        }

        // Get all font files (adjust the extension based on your font files - .ttf, .otf etc)
        let fontURLs = try? FileManager.default.contentsOfDirectory(
            at: bundleURL.appendingPathComponent("Fonts"),
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )

        fontURLs?.forEach { url in
            guard let fontDataProvider = CGDataProvider(url: url as CFURL),
                  let font = CGFont(fontDataProvider) else {
                return
            }

            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("Error registering font: \(error.debugDescription)")
            }
        }
    }
}
