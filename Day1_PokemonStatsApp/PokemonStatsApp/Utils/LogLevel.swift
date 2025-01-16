//
//  LogLevel.swift
//  PokemonStatsApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// Represents different severity levels for logging messages.
///
/// Each log level has an associated emoji prefix for better visual distinction in the console:
/// - `debug`: Used for detailed information during development (🔍)
/// - `info`: Used for general information about program execution (📡)
/// - `error`: Used for error conditions that require attention (❌)
enum LogLevel {

    /// Used for detailed debugging information
    case debug

    /// Used for general operational information
    case info

    /// Used for error conditions and failures
    case error

    /// Returns the emoji prefix associated with each log level
    /// for visual distinction in log output.
    var prefix: String {
        switch self {
        case .debug: return "🔧"
        case .info: return "ℹ️"
        case .error: return "⛔️"
        }
    }
}
