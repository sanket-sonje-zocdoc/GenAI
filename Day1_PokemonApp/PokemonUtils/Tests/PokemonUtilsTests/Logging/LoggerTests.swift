//
//  LoggerTests.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 02/01/25.
//

import XCTest

@testable import PokemonUtils

@MainActor
final class LoggerTests: PokemonUtilsUnitTestCase {

    // MARK: - Properties

    private var logger: Logger!

    // MARK: - Setup

    override func setUp() async throws {
        await MainActor.run {
            super.setUp()
        }

        logger = Logger.shared
    }

    // MARK: - Tests

    func testLoggerSingleton() {
        let anotherLogger = Logger.shared
        XCTAssertTrue(logger === anotherLogger, "Logger should maintain singleton instance")
    }

    func testLogFormatting() {
        // Create a pipe to capture stdout
        let pipe = Pipe()
        let originalStdout = dup(STDOUT_FILENO)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        // Log a test message
        logger.log("Test message", level: .info, file: "TestFile.swift", line: 42)

        // Restore stdout
        dup2(originalStdout, STDOUT_FILENO)
        close(originalStdout)
        pipe.fileHandleForWriting.closeFile()

        // Read captured output
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        // Verify log format
        let expectedOutput = "ℹ️[TestFile.swift:42] Test message\n"
        XCTAssertEqual(output, expectedOutput, "Log output should match expected format")
    }

    func testDifferentLogLevels() {
        let pipe = Pipe()
        let originalStdout = dup(STDOUT_FILENO)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)

        // Test all log levels
        logger.log("Debug message", level: .debug, file: "Test.swift", line: 1)
        logger.log("Info message", level: .info, file: "Test.swift", line: 2)
        logger.log("Warning message", level: .warning, file: "Test.swift", line: 3)
        logger.log("Error message", level: .error, file: "Test.swift", line: 4)

        // Restore stdout
        dup2(originalStdout, STDOUT_FILENO)
        close(originalStdout)
        pipe.fileHandleForWriting.closeFile()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        // Verify each log level output
        let expectedOutput = """
        🔍[Test.swift:1] Debug message
        ℹ️[Test.swift:2] Info message
        ⚠️[Test.swift:3] Warning message
        ❌[Test.swift:4] Error message
        
        """

        XCTAssertEqual(output, expectedOutput, "Log outputs should match expected formats for all levels")
    }
}
