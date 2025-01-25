//
//  Logger.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A singleton logger class that handles debug message logging in the application.
/// This logger only prints messages in DEBUG builds.
class Logger {

    // MARK: - Properties

    /// The shared instance of the Logger class.
    static let shared = Logger()

    // MARK: - Inits

    /// Private initializer to enforce singleton pattern.
    private init() {

    }

    // MARK: - Methods

    /// Logs a message with the specified log level.
    /// - Parameters:
    ///   - message: The message to be logged
    ///   - level: The severity level of the log message (default: .info)
    ///   - file: The file name from where the log is called (automatically captured)
    ///   - line: The line number from where the log is called (automatically captured)
    func log(
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
