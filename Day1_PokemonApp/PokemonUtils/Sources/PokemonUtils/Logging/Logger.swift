//
//  Logger.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation
import os

/// A singleton logger class that provides centralized logging functionality for the application.
/// The logger is designed to assist in debugging by providing formatted log messages that include
/// file names, line numbers, and configurable severity levels.
///
/// Usage Example:
/// ```
/// Logger.shared.log("User authentication failed", level: .error)
/// Logger.shared.log("Loading data...", level: .info)
/// ```
///
/// Note: Log messages are only printed in DEBUG builds to ensure no sensitive information
/// is exposed in production environments.
public final class Logger: Sendable {

    // MARK: - Properties

    /// The shared singleton instance of the Logger class.
    /// Use this property to access logging functionality throughout the application.
    public static let shared = Logger()

    // MARK: - Inits

    /// Private initializer to enforce singleton pattern.
    /// This prevents creation of additional Logger instances.
    private init() {}

    // MARK: - Methods

    /// Logs a message with the specified severity level and source information.
    /// 
    /// - Parameters:
    ///   - message: The message to be logged. This should be descriptive and relevant to the current operation.
    ///   - level: The severity level of the log message (default: .info). Use appropriate levels to categorize messages:
    ///     - .debug for detailed debugging information
    ///     - .info for general information
    ///     - .warning for potentially problematic situations
    ///     - .error for error conditions
    ///   - file: The source file name where the log is called (automatically captured)
    ///   - line: The line number in the source file where the log is called (automatically captured)
    ///
    /// - Note: Logs are only printed in DEBUG builds and will be stripped from release builds.
    public func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        line: Int = #line
    ) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(level.prefix)[\(fileName):\(line)] \(message)")
        #endif
    }
}
