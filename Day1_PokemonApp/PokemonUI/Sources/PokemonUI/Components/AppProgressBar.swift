//
//  AppProgressBar.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

/// A custom progress bar component that shows a visual representation of a value within a given range.
/// The progress bar automatically changes color based on the percentage filled, unless a custom color is provided.
///
/// Color Ranges:
/// - Red (0-20%): Indicates very low progress
/// - Light Red (21-40%): Indicates low progress
/// - Yellow (41-60%): Indicates moderate progress
/// - Light Green (61-80%): Indicates good progress
/// - Green (81-100%): Indicates excellent progress
///
/// - Note: The value is automatically clamped between 0 and maxValue to prevent invalid states.
/// - Important: The `a11yID` parameter is required for accessibility and UI testing purposes.
public struct AppProgressBar: View {

    // MARK: - Properties

    private let value: Double
    private let maxValue: Double
    private let frame: CGSize
    private let cornerRadius: CGFloat
    private let customForegroundColor: Color?
    private let accessibilityID: String

    /// The color of the progress bar, determined by the current percentage or custom color if provided.
    var foregroundColor: Color {
        if let customColor = customForegroundColor {
            return customColor
        }

        let percentage = (value / maxValue) * 100
        switch percentage {
        case 0...20:
            return .red
        case 21...40:
            return Color(red: 1.0, green: 0.5, blue: 0.5)
        case 41...60:
            return .yellow
        case 61...80:
            return Color(red: 0.5, green: 0.8, blue: 0.5)
        default:
            return .green
        }
    }

    // MARK: - Initialization

    /// Creates a new AppProgressBar instance
    /// - Parameters:
    ///   - value: The current value to display
    ///   - maxValue: The maximum possible value (will be capped at 100)
    ///   - frame: The height of the progress bar (defaults to 100x8 points)
    ///   - cornerRadius: The corner radius of the progress bar (defaults to 4 points)
    ///   - foregroundColor: Optional custom color for the progress bar
    ///   - accessibilityID: The accessibility identifier for the progress bar
    public init(
        value: Double,
        maxValue: Double = 100,
        frame: CGSize = AppStyle.Frame.progressBar,
        cornerRadius: CGFloat = AppStyle.Radius.corner,
        foregroundColor: Color? = nil,
        accessibilityID: String
    ) {
        let cappedMaxValue = min(maxValue, 100)
        self.value = min(max(value, 0), cappedMaxValue)
        self.maxValue = cappedMaxValue
        self.frame = frame
        self.cornerRadius = cornerRadius
        self.customForegroundColor = foregroundColor
        self.accessibilityID = accessibilityID
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(AppStyle.ShadowColors.primary)

                Rectangle()
                    .fill(foregroundColor)
                    .frame(width: calculateProgressWidth(totalWidth: geometry.size.width))
                    .a11yID(accessibilityID, view: .appProgressBar, component: .progressView)
            }
        }
        .frame(width: frame.width, height: frame.height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    // MARK: - Helper Methods

    private func calculateProgressWidth(totalWidth: CGFloat) -> CGFloat {
        let progress = value / maxValue
        return totalWidth * CGFloat(progress)
    }
}

#Preview {
    VStack(spacing: 20) {
        AppProgressBar(value: 10, maxValue: 100, accessibilityID: "Test")
        AppProgressBar(value: 30, maxValue: 100, accessibilityID: "Test")
        AppProgressBar(value: 50, maxValue: 100, accessibilityID: "Test")
        AppProgressBar(value: 70, maxValue: 100, accessibilityID: "Test")
        AppProgressBar(value: 90, maxValue: 100, accessibilityID: "Test")

        AppProgressBar(
            value: 75,
            maxValue: 100,
            frame: CGSize(width: 200,height: 20),
            cornerRadius: 6,
            accessibilityID: "Test"
        )

        AppProgressBar(
            value: 25,
            maxValue: 100,
            accessibilityID: "Test"
        )
    }
    .padding()
}
