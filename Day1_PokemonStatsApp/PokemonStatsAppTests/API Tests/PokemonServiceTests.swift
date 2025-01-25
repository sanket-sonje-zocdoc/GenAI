import XCTest

@testable import PokemonStatsApp

final class PokemonServiceTests: XCTestCase {

    // MARK: - Properties

    private var pokemonService: PokemonService!
    private var configuration: URLSessionConfiguration!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        pokemonService = PokemonService(session: session)
    }

    override func tearDown() {
        pokemonService = nil
        configuration = nil
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        super.tearDown()
    }

    // MARK: - FetchPokemonList Tests

    func test_fetchPokemonList_success() async throws {
        // Given
        MockURLProtocol.mockData = JSONMocker.loadMockData(from: "pokemon_list")
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=25"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When
        let result = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)

        // Then
        XCTAssertEqual(result.count, 25)
    }

    func test_fetchPokemonList_invalidURL() async {
        // Given
        MockURLProtocol.mockError = URLError(.badURL)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func test_fetchPokemonList_networkError() async {
        // Given
        MockURLProtocol.mockError = URLError(.notConnectedToInternet)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }

    func test_fetchPokemonList_invalidResponse() async throws {
        // Given
        MockURLProtocol.mockData = JSONMocker.loadMockData(from: "invalid_pokemon_list")
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=25"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_fetchPokemonList_emptyResponse() async throws {
        // Given
        MockURLProtocol.mockData = JSONMocker.loadMockData(from: "empty_pokemon_list")
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=25"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When
        let result = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)

        // Then
        XCTAssertTrue(result.isEmpty)
    }

    func test_fetchPokemonList_badStatusCode() async throws {
        // Given
        MockURLProtocol.mockData = Data()
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=25"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidStatusCode(404))
        } catch {
            XCTFail("Expected NetworkError but got \(error)")
        }
    }

    func test_fetchPokemonList_noResponse() async throws {
        // Given
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = URLError(.unknown)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .unknown)
        } catch {
            XCTFail("Expected URLError but got \(error)")
        }
    }

    func test_fetchPokemonList_timeoutError() async {
        // Given
        MockURLProtocol.mockError = URLError(.timedOut)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemonList(offset: 0, limit: 25)
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .timedOut)
        } catch {
            XCTFail("Expected URLError.timedOut but got \(error)")
        }
    }

    // MARK: - FetchPokemon Tests

    func test_fetchPokemon_success() async throws {
        // Given
        let mockData = JSONMocker.loadMockData(from: "pokemon_detail")
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon/63"))
        
        MockURLProtocol.mockData = mockData
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When
        let pokemon = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")

        // Then
        XCTAssertEqual(pokemon.id, 63)
        XCTAssertEqual(pokemon.name, "abra")
        XCTAssertEqual(pokemon.stats.count, 1)
        XCTAssertEqual(pokemon.stats[0].baseStat, 25)
    }

    func test_fetchPokemon_invalidaURL_type1() async {
        // Given
        MockURLProtocol.mockError = URLError(.badURL)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://invalid-url")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .badURL)
        }
    }

    func test_fetchPokemon_invalidaURL_type2() async {
        // Given
        let invalidURL = "not a url"

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: invalidURL)
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badURL)
        } catch {
            XCTFail("Expected URLError.badURL but got \(error)")
        }
    }

    func test_fetchPokemon_networkError() async {
        // Given
        MockURLProtocol.mockError = URLError(.notConnectedToInternet)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }

    func test_fetchPokemon_invalidResponse() async throws {
        // Given
        MockURLProtocol.mockData = JSONMocker.loadMockData(from: "invalid_pokemon_detail")
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon/63"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_fetchPokemon_badStatusCode() async throws {
        // Given
        MockURLProtocol.mockData = Data()
        let url = try XCTUnwrap(URL(string: "https://pokeapi.co/api/v2/pokemon/63"))
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")
            XCTFail("Expected error but got success")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidStatusCode(500))
        } catch {
            XCTFail("Expected NetworkError but got \(error)")
        }
    }

    func test_fetchPokemon_noResponse() async throws {
        // Given
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = URLError(.unknown)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .unknown)
        } catch {
            XCTFail("Expected URLError but got \(error)")
        }
    }

    func test_fetchPokemon_timeoutError() async {
        // Given
        MockURLProtocol.mockError = URLError(.timedOut)

        // When/Then
        do {
            _ = try await pokemonService.fetchPokemon(url: "https://pokeapi.co/api/v2/pokemon/63")
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .timedOut)
        } catch {
            XCTFail("Expected URLError.timedOut but got \(error)")
        }
    }
}

