//
//  MockURLProtocol.swift
//  PokemonApp
//
//  Created by Sanket Sonje on 15/01/25.
//

import Foundation

/// A mock URL protocol implementation used for testing network requests without making actual network calls.
/// This class allows you to simulate network responses by providing mock data, responses, and errors.
///
/// Usage Example:
/// ```
/// // Setup mock data
/// MockURLProtocol.mockData = jsonData
/// MockURLProtocol.mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
///
/// // Configure URLSession with mock protocol
/// let configuration = URLSessionConfiguration.ephemeral
/// configuration.protocolClasses = [MockURLProtocol.self]
/// let session = URLSession(configuration: configuration)
/// ```
class MockURLProtocol: URLProtocol {

    // MARK: - Private properties

    /// The mock data to be returned in the response.
    /// Set this property before making test network calls.
    static var mockData: Data?
    
    /// The mock URLResponse to be returned.
    /// Set this property before making test network calls.
    static var mockResponse: URLResponse?
    
    /// The mock error to be returned.
    /// Set this property to simulate network errors in tests.
    static var mockError: Error?

    // MARK: - URLProtocol Overrides

    /// Determines whether this protocol can handle the given request.
    /// - Parameter request: The URL request to handle
    /// - Returns: Always returns true as this mock handles all requests
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    /// Returns a canonical version of the given request.
    /// - Parameter request: The URL request to canonicalize
    /// - Returns: The same request as no modifications are needed for testing
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    /// Starts loading the request.
    /// This method simulates a network response using the provided mock data, response, or error.
    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        guard let url = request.url, url.absoluteString.starts(with: "https://") else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }

        guard let response = MockURLProtocol.mockResponse else {
            client?.urlProtocol(self, didFailWithError: URLError(.unknown))
            return
        }

        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    /// Stops loading the request.
    /// This is a no-op in the mock implementation.
    override func stopLoading() {
        // NO-OP
    }
}
