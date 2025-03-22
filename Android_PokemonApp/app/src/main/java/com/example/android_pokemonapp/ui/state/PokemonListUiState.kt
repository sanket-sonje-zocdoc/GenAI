package com.example.android_pokemonapp.ui.state

import com.example.android_pokemonapp.data.model.PokemonListItem

sealed interface PokemonListUiState {
	data object Loading : PokemonListUiState
	data class Success(
		val pokemons: List<PokemonListItem>,
		val isNextPageAvailable: Boolean,
		val isPreviousPageAvailable: Boolean,
		val totalCount: Int
	) : PokemonListUiState

	data class Error(val error: Exception) : PokemonListUiState
}
