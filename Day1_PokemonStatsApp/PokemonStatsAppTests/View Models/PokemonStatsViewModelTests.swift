import XCTest

@testable import PokemonStatsApp

@MainActor
class PokemonStatsViewModelTests: XCTestCase {

    // MARK: - Properties

    private var mockViewModel: PokemonStatsViewModel!
    private var mockPokemonService: MockPokemonService!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()
        mockPokemonService = MockPokemonService()
        mockViewModel = PokemonStatsViewModel(pokemonService: mockPokemonService)
    }

    override func tearDown() {
        mockViewModel = nil
        mockPokemonService = nil
        super.tearDown()
    }

    // MARK: - Initial State Tests

    func testInitialState() {
        XCTAssertTrue(mockViewModel.pokemons.isEmpty)
        XCTAssertTrue(mockViewModel.pokemonList.isEmpty)
        XCTAssertNil(mockViewModel.error)
        XCTAssertFalse(mockViewModel.isLoadingMore)
    }

    // MARK: - Fetch Initial Pokemon List Tests

    func testFetchInitialPokemonList_Success() async {
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

    func testFetchInitialPokemonList_Failure() async {
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

    func testLoadMorePokemon_Success() async {
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

    func testLoadMorePokemon_WhenAlreadyLoading_DoesNothing() async {
        // Given
        mockViewModel.isLoadingMore = true

        // When
        await mockViewModel.loadMorePokemon()

        // Then
        XCTAssertTrue(mockViewModel.pokemonList.isEmpty)
    }
}
