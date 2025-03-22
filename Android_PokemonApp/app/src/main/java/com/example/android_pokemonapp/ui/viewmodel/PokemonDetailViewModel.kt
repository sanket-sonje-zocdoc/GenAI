package com.example.android_pokemonapp.ui.viewmodel

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.android_pokemonapp.data.repository.PokemonRepository
import com.example.android_pokemonapp.data.util.Result
import com.example.android_pokemonapp.ui.state.PokemonDetailUiState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * ViewModel for managing Pokemon detail screen UI state and business logic.
 *
 * This ViewModel handles loading and displaying detailed information about a specific Pokemon.
 * It manages the UI state updates and provides methods to load and refresh Pokemon details.
 *
 * @property repository Repository for fetching Pokemon data
 * @property savedStateHandle Handle for saving and restoring ViewModel state
 */
@HiltViewModel
class PokemonDetailViewModel @Inject constructor(
	private val repository: PokemonRepository,
	private val savedStateHandle: SavedStateHandle
) : ViewModel() {

	private val _uiState = MutableStateFlow<PokemonDetailUiState>(PokemonDetailUiState.Loading)

	/**
	 * Observable UI state for the Pokemon detail screen.
	 *
	 * Emits updates to the UI state when Pokemon details are loading, loaded successfully,
	 * or when an error occurs.
	 */
	val uiState: StateFlow<PokemonDetailUiState> = _uiState.asStateFlow()

	/**
	 * Loads detailed information about a specific Pokemon.
	 *
	 * Updates the UI state to reflect the loading status and result of the operation.
	 *
	 * @param pokemonId The unique identifier of the Pokemon to load
	 */
	fun loadPokemonDetail(pokemonId: Int) {
		viewModelScope.launch {
			_uiState.value = PokemonDetailUiState.Loading
			when (val result = repository.getPokemonById(pokemonId)) {
				is Result.Success -> {
					_uiState.value = PokemonDetailUiState.Success(result.data)
				}

				is Result.Error -> {
					_uiState.value = PokemonDetailUiState.Error(result.exception)
				}
			}
		}
	}

	/**
	 * Refreshes the currently displayed Pokemon details.
	 *
	 * Reloads the Pokemon details from the repository, useful for pull-to-refresh
	 * functionality or manual refresh requests.
	 *
	 * @param pokemonId The unique identifier of the Pokemon to refresh
	 */
	fun refresh(pokemonId: Int) {
		loadPokemonDetail(pokemonId)
	}
}
