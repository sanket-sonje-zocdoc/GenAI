package com.example.android_pokemonapp.ui.state

import com.example.android_pokemonapp.data.model.Pokemon

/**
 * Represents the UI state for the Pokemon detail screen.
 *
 * This sealed interface encapsulates all possible states that the Pokemon detail UI can be in,
 * including loading, success with data, and error states.
 */
sealed interface PokemonDetailUiState {

	/**
	 * Indicates that the Pokemon details are being loaded.
	 */
	data object Loading : PokemonDetailUiState

	/**
	 * Represents a successful state containing the Pokemon details.
	 *
	 * @property pokemon The Pokemon details to be displayed
	 */
	data class Success(val pokemon: Pokemon) : PokemonDetailUiState

	/**
	 * Represents an error state when Pokemon details couldn't be loaded.
	 *
	 * @property error The exception that caused the error
	 */
	data class Error(val error: Exception) : PokemonDetailUiState
}
