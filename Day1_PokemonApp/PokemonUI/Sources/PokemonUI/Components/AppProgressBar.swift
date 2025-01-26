//
//  AppProgressBar.swift
//  PokemonUI
//
//  Created by Sanket Sonje on 26/01/25.
//

import SwiftUI

/// A custom progress bar component that shows a visual representation of a value within a given range.
/// The progress bar automatically changes color based on the percentage filled:
/// - Red (0-20%): Indicates very low progress
/// - Light Red (21-40%): Indicates low progress
/// - Yellow (41-60%): Indicates moderate progress
/// - Light Green (61-80%): Indicates good progress
/// - Green (81-100%): Indicates excellent progress
///
/// Example usage:
/// ```
/// AppProgressBar(value: 75, maxValue: 100) // Creates a progress bar at 75%
/// AppProgressBar(value: 50, maxValue: 100, height: 12, cornerRadius: 6) // Creates a customized progress bar
/// ```
public struct AppProgressBar: View {

    // MARK: - Properties

    private let value: Double
    private let maxValue: Double
    private let height: CGFloat
    private let cornerRadius: CGFloat

    /// The color of the progress bar, determined by the current percentage.
    /// Changes dynamically as the value changes relative to maxValue.
    var foregroundColor: Color {
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
    ///   - maxValue: The maximum possible value (used to calculate the fill percentage)
    ///   - height: The height of the progress bar (defaults to 8 points)
    ///   - cornerRadius: The corner radius of the progress bar (defaults to 4 points)
    public init(
        value: Double,
        maxValue: Double,
        height: CGFloat = 8,
        cornerRadius: CGFloat = 4
    ) {
        self.value = min(max(value, 0), maxValue)
        self.maxValue = maxValue
        self.height = height
        self.cornerRadius = cornerRadius
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(foregroundColor)
                    .frame(width: calculateProgressWidth(totalWidth: geometry.size.width))
            }
        }
        .frame(height: height)
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
        AppProgressBar(value: 10, maxValue: 100)
        AppProgressBar(value: 30, maxValue: 100)
        AppProgressBar(value: 50, maxValue: 100)
        AppProgressBar(value: 70, maxValue: 100)
        AppProgressBar(value: 90, maxValue: 100)

        AppProgressBar(
            value: 75,
            maxValue: 100,
            height: 12,
            cornerRadius: 6
        )

        AppProgressBar(
            value: 25,
            maxValue: 100
        )
    }
    .padding()
}
