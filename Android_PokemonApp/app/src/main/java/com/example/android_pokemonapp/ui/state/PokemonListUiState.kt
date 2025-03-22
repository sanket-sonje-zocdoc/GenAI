package com.example.android_pokemonapp.ui.state

import com.example.android_pokemonapp.data.model.PokemonListItem

/**
 * Represents the UI state for the Pokemon list screen.
 *
 * This sealed interface encapsulates all possible states that the Pokemon list UI can be in,
 * including loading, success with paginated data, and error states.
 */
sealed interface PokemonListUiState {
	/**
	 * Indicates that the Pokemon list is being loaded.
	 */
	data object Loading : PokemonListUiState

	/**
	 * Represents a successful state containing the paginated Pokemon list.
	 *
	 * @property pokemons List of Pokemon items to be displayed
	 * @property isNextPageAvailable Whether there are more Pokemon items available to load
	 * @property isPreviousPageAvailable Whether there are previous Pokemon items available to load
	 * @property totalCount Total number of Pokemon available in the API
	 */
	data class Success(
		val pokemons: List<PokemonListItem>,
		val isNextPageAvailable: Boolean,
		val isPreviousPageAvailable: Boolean,
		val totalCount: Int
	) : PokemonListUiState

	/**
	 * Represents an error state when Pokemon list couldn't be loaded.
	 *
	 * @property error The exception that caused the error
	 */
	data class Error(val error: Exception) : PokemonListUiState
}
