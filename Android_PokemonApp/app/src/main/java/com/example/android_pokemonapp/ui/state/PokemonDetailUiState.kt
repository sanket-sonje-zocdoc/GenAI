package com.example.android_pokemonapp.ui.state

import com.example.android_pokemonapp.data.model.Pokemon

sealed interface PokemonDetailUiState {
	data object Loading : PokemonDetailUiState
	data class Success(val pokemon: Pokemon) : PokemonDetailUiState
	data class Error(val error: Exception) : PokemonDetailUiState
}
