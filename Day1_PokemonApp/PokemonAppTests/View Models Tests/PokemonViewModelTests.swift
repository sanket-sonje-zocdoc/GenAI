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
        XCTAssertTrue(mockViewModel.pokemonList.isEmpty)
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
        mockPokemonService.mockPokemonList = mockPokemonList

        // When
        await mockViewModel.fetchInitialPokemonList()

        // Then
        XCTAssertEqual(mockViewModel.pokemonList.count, 2)
        XCTAssertEqual(mockViewModel.pokemonList.first?.name, "bulbasaur")
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
        XCTAssertTrue(mockViewModel.pokemonList.isEmpty)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    // MARK: - Load More Pokemon Tests

    func test_loadMorePokemon_success() async {
        // Given
        let initialList = Array(repeating: PokemonListItem(name: "bulbasaur", url: "pokemon/1"), count: 25)
        let additionalList = [PokemonListItem(name: "charmander", url: "pokemon/4")]
        mockPokemonService.mockPokemonList = initialList

        // When
        await mockViewModel.fetchInitialPokemonList()
        mockPokemonService.mockPokemonList = additionalList
        await mockViewModel.loadMorePokemon()

        // Then
        XCTAssertEqual(mockViewModel.pokemonList.count, 26)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    func test_loadMorePokemon_whenAlreadyLoading_doesNothing() async {
        // Given
        mockViewModel.isLoadingMore = true

        // When
        await mockViewModel.loadMorePokemon()

        // Then
        XCTAssertTrue(mockViewModel.pokemonList.isEmpty)
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
}
