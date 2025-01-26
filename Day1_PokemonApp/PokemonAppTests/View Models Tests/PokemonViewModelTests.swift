import XCTest

@testable import PokemonApp

@MainActor
class PokemonViewModelTests: XCTestCase {

    // MARK: - Properties

    private var mockViewModel: PokemonViewModel!
    private var mockPokemonService: MockPokemonService!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        mockPokemonService = MockPokemonService()
        mockViewModel = PokemonViewModel(pokemonService: mockPokemonService)
    }

    override func tearDown() {
        mockViewModel = nil
        mockPokemonService = nil
        super.tearDown()
    }

    // MARK: - Initial State Tests

    func test_initialState() {
        XCTAssertTrue(mockViewModel.pokemons.isEmpty)
        XCTAssertTrue(mockViewModel.pokemonListItems.isEmpty)
        XCTAssertNil(mockViewModel.error)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    // MARK: - Fetch Initial Pokemon List Tests

    func test_fetchInitialPokemonList_success() async {
        // Given
        let mockPokemonList = [
            PokemonListItem(name: "bulbasaur", url: "pokemon/1"),
            PokemonListItem(name: "charmander", url: "pokemon/4")
        ]
        mockPokemonService.setMockResponse(mockPokemonList, for: [PokemonListItem].self)

        // When
        await mockViewModel.fetchInitialPokemonList()

        // Then
        XCTAssertEqual(mockViewModel.pokemonListItems.count, 2)
        XCTAssertEqual(mockViewModel.pokemonListItems.first?.name, "bulbasaur")
        XCTAssertFalse(mockViewModel.isLoadingMore)
        XCTAssertNil(mockViewModel.error)
    }

    func test_fetchInitialPokemonList_failure() async {
        // Given
        let expectedError = NSError(domain: "test", code: 1, userInfo: nil)
        mockPokemonService.mockError = expectedError

        // When
        await mockViewModel.fetchInitialPokemonList()

        // Then
        XCTAssertNotNil(mockViewModel.error)
        XCTAssertTrue(mockViewModel.pokemonListItems.isEmpty)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    // MARK: - Load More Pokemon Tests

    func test_loadMorePokemon_success() async {
        // Given
        let initialList = Array(repeating: PokemonListItem(name: "bulbasaur", url: "pokemon/1"), count: 25)
        mockPokemonService.setMockResponse(initialList, for: [PokemonListItem].self)

        // When - First load
        await mockViewModel.fetchInitialPokemonList()

        // Then - Verify initial load
        XCTAssertEqual(mockViewModel.pokemonListItems.count, 25)

        // Given - Setup for load more
        let additionalList = [PokemonListItem(name: "charmander", url: "pokemon/4")]
        mockPokemonService.setMockResponse(additionalList, for: [PokemonListItem].self)

        // When - Load more
        await mockViewModel.loadMorePokemon()

        // Then
        XCTAssertEqual(mockViewModel.pokemonListItems.count, 26)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    func test_loadMorePokemon_failure() async {
        // Given
        let initialList = Array(repeating: PokemonListItem(name: "bulbasaur", url: "pokemon/1"), count: 25)
        mockPokemonService.setMockResponse(initialList, for: [PokemonListItem].self)
        await mockViewModel.fetchInitialPokemonList()

        // Setup failure for load more
        mockPokemonService.mockError = NetworkError.invalidStatusCode(500)

        // When
        await mockViewModel.loadMorePokemon()

        // Then
        XCTAssertNotNil(mockViewModel.error)
        XCTAssertEqual(mockViewModel.pokemonListItems.count, 25)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    func test_fetchPokemonDetail_success() async throws {
        // Given
        let mockPokemon = createMockPokemon(name: "Pikachu", types: ["electric"])
        mockPokemonService.setMockResponse(mockPokemon, for: Pokemon.self)

        // When
        let result: Pokemon = try await mockPokemonService.fetchItem(url: "any-url")

        // Then
        XCTAssertEqual(result.name, "Pikachu")
        XCTAssertEqual(result.types.first?.type.name, "electric")
    }

    func test_fetchPokemonDetail_failure() async {
        // Given
        mockPokemonService.mockError = NetworkError.invalidStatusCode(404)

        // When
        do {
            let _: Pokemon = try await mockPokemonService.fetchItem(url: "any-url")
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            // Then
            switch error {
            case .invalidStatusCode(let code):
                XCTAssertEqual(code, 404)
            default:
                XCTFail("Expected invalidStatusCode error")
            }
        } catch {
            XCTFail("Expected NetworkError")
        }
    }

    // MARK: - Filter Pokemon Tests

    func test_filterPokemons_withEmptySearchText() {
        // Given
        let mockPokemons = [MockPokemon.pikachu, MockPokemon.charmander]
        mockViewModel.pokemons = mockPokemons

        // When
        let filteredPokemons = mockViewModel.filterPokemons(for: "", mode: .name)

        // Then
        XCTAssertEqual(filteredPokemons.count, 2)
        XCTAssertEqual(filteredPokemons, mockPokemons)
    }

    func test_filterPokemons_withNameSearchText() {
        // Given
        mockViewModel.pokemons = [MockPokemon.pikachu, MockPokemon.charmander]

        // When
        let filteredPokemons = mockViewModel.filterPokemons(for: "char", mode: .name)

        // Then
        XCTAssertEqual(filteredPokemons.count, 1)
        XCTAssertEqual(filteredPokemons.first?.name, "charmander")
    }

    func test_filterPokemons_withTypeSearchText() {
        // Given
        mockViewModel.pokemons = [MockPokemon.pikachu, MockPokemon.charmander]

        // When
        let filteredPokemons = mockViewModel.filterPokemons(for: "fire", mode: .type)

        // Then
        XCTAssertEqual(filteredPokemons.count, 1)
        XCTAssertEqual(filteredPokemons.first?.name, "charmander")
    }

    func test_filterPokemons_withCaseInsensitiveNameSearch() {
        // Given
        mockViewModel.pokemons = [MockPokemon.pikachu, MockPokemon.charmander]

        // When
        let filteredPokemons = mockViewModel.filterPokemons(for: "piKacH", mode: .name)

        // Then
        XCTAssertEqual(filteredPokemons.count, 1)
        XCTAssertEqual(filteredPokemons.first?.name, "pikachu")
    }

    func test_filterPokemons_withNonMatchingSearchText() {
        // Given
        mockViewModel.pokemons = [MockPokemon.pikachu, MockPokemon.charmander]

        // When
        let filteredPokemons = mockViewModel.filterPokemons(for: "bulbasaur", mode: .name)

        // Then
        XCTAssertTrue(filteredPokemons.isEmpty)
    }

    // MARK: - Sort Pokemon Tests

    func test_sortPokemons_byNameAscending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Pikachu", stats: [:])
        let pokemon2 = createMockPokemon(name: "Charizard", stats: [:])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .name, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Charizard", "Pikachu"])
    }

    func test_sortPokemons_byNameDescending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Pikachu", stats: [:])
        let pokemon2 = createMockPokemon(name: "Charizard", stats: [:])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .name, ascending: false)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Pikachu", "Charizard"])
    }

    func test_sortPokemons_byStatAscending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Pikachu", stats: ["hp": 35])
        let pokemon2 = createMockPokemon(name: "Charizard", stats: ["hp": 78])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .hp, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Pikachu", "Charizard"])
    }

    func test_sortPokemons_byStatDescending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Pikachu", stats: ["hp": 35])
        let pokemon2 = createMockPokemon(name: "Charizard", stats: ["hp": 78])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .hp, ascending: false)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Charizard", "Pikachu"])
    }

    func test_sortPokemons_withMissingStats() {
        // Given
        let pokemon1 = createMockPokemon(name: "Pikachu", stats: ["hp": 35])
        let pokemon2 = createMockPokemon(name: "Charizard", stats: [:])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .hp, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Charizard", "Pikachu"])
    }

    // MARK: - Sort Pokemon Tests

    func test_sortPokemons_byTypeAscending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire", "flying"])
        let pokemon2 = createMockPokemon(name: "Pikachu", types: ["electric"])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .type, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Pikachu", "Charizard"])
        XCTAssertEqual(sorted.map { $0.types.first?.type.name }, ["electric", "fire"])
    }

    func test_sortPokemons_byTypeDescending() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire", "flying"])
        let pokemon2 = createMockPokemon(name: "Pikachu", types: ["electric"])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .type, ascending: false)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Charizard", "Pikachu"])
        XCTAssertEqual(sorted.map { $0.types.first?.type.name }, ["fire", "electric"])
    }

    func test_sortPokemons_byType_withEmptyTypes() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire"])
        let pokemon2 = createMockPokemon(name: "MissingNo", types: [])
        mockViewModel.pokemons = [pokemon1, pokemon2]
        mockViewModel.sortCriteria = [SortCriteria(option: .type, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["MissingNo", "Charizard"])
    }

    func test_sortPokemons_byType_withMultipleTypes() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire", "flying"])
        let pokemon2 = createMockPokemon(name: "Gyarados", types: ["water", "flying"])
        let pokemon3 = createMockPokemon(name: "Pikachu", types: ["electric"])
        mockViewModel.pokemons = [pokemon1, pokemon2, pokemon3]
        mockViewModel.sortCriteria = [SortCriteria(option: .type, ascending: true)]

        // When
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Pikachu", "Charizard", "Gyarados"])
        XCTAssertEqual(
            sorted.map { $0.types.map { $0.type.name }.joined(separator: ",") },
            ["electric", "fire,flying", "water,flying"]
        )
    }

    // MARK: - Multiple Sort Criteria Tests

    func test_sortPokemons_withMultipleCriteria() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire"], stats: ["hp": 78])
        let pokemon2 = createMockPokemon(name: "Blastoise", types: ["water"], stats: ["hp": 78])
        let pokemon3 = createMockPokemon(name: "Venusaur", types: ["grass"], stats: ["hp": 80])
        mockViewModel.pokemons = [pokemon1, pokemon2, pokemon3]

        // When - Sort by HP descending, then by name ascending
        mockViewModel.sortCriteria = [
            SortCriteria(option: .hp, ascending: false),
            SortCriteria(option: .name, ascending: true)
        ]
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Venusaur", "Blastoise", "Charizard"])
    }

    func test_sortPokemons_withMultipleCriteria_sameValues() {
        // Given
        let pokemon1 = createMockPokemon(name: "Charizard", types: ["fire"], stats: ["hp": 78])
        let pokemon2 = createMockPokemon(name: "Blastoise", types: ["water"], stats: ["hp": 78])
        mockViewModel.pokemons = [pokemon1, pokemon2]

        // When - Sort by HP descending (same values), then by name ascending
        mockViewModel.sortCriteria = [
            SortCriteria(option: .hp, ascending: false),
            SortCriteria(option: .name, ascending: true)
        ]
        let sorted = mockViewModel.sortPokemons(mockViewModel.pokemons)

        // Then
        XCTAssertEqual(sorted.map { $0.name }, ["Blastoise", "Charizard"])
    }

    func test_addSortCriteria_replacesExistingOption() {
        // Given
        mockViewModel.addSortCriteria(option: .name, ascending: true)

        // When
        mockViewModel.addSortCriteria(option: .name, ascending: false)

        // Then
        XCTAssertEqual(mockViewModel.sortCriteria.count, 1)
        XCTAssertEqual(mockViewModel.sortCriteria.first?.option, .name)
        XCTAssertFalse(mockViewModel.sortCriteria.first?.ascending ?? true)
    }

    func test_removeSortCriteria() {
        // Given
        mockViewModel.addSortCriteria(option: .name, ascending: true)
        mockViewModel.addSortCriteria(option: .hp, ascending: false)

        // When
        mockViewModel.removeSortCriteria(option: .name)

        // Then
        XCTAssertEqual(mockViewModel.sortCriteria.count, 1)
        XCTAssertEqual(mockViewModel.sortCriteria.first?.option, .hp)
    }

    // MARK: - Helper Methods

    private func createMockPokemon(name: String, types: [String] = [], stats: [String: Int] = [:]) -> Pokemon {
        let pokemonTypesEntry = types.map {
            PokemonTypeEntry(
                slot: 1,
                type: PokemonType(name: $0, url: "")
            )

        }

        let pokemonStats = stats.map {
            Stat(
                baseStat: $0.value,
                effort: 0,
                stat: StatInfo(
                    name: $0.key,
                    url: ""
                )
            )
        }

        return Pokemon(
            id: 1,
            name: name,
            height: 0,
            weight: 0,
            sprites: Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                frontShiny: ""
            ),
            stats: pokemonStats,
            types: pokemonTypesEntry
        )
    }
}
