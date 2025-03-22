package com.example.android_pokemonapp.ui.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.android_pokemonapp.data.repository.PokemonRepository
import com.example.android_pokemonapp.data.util.Result
import com.example.android_pokemonapp.ui.state.PokemonListUiState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * ViewModel for managing Pokemon list screen UI state and business logic.
 *
 * This ViewModel handles loading and displaying a paginated list of Pokemon.
 * It manages the UI state updates and provides methods for pagination and refresh functionality.
 *
 * @property repository Repository for fetching Pokemon data
 */
@HiltViewModel
class PokemonListViewModel @Inject constructor(
	private val repository: PokemonRepository
) : ViewModel() {

	private val _uiState = MutableStateFlow<PokemonListUiState>(PokemonListUiState.Loading)

	/**
	 * Observable UI state for the Pokemon list screen.
	 *
	 * Emits updates to the UI state when Pokemon list is loading, loaded successfully,
	 * or when an error occurs.
	 */
	val uiState: StateFlow<PokemonListUiState> = _uiState.asStateFlow()

	/** Current pagination offset */
	private var currentOffset = 0

	/** Number of items to load per page */
	private val pageSize = 20

	init {
		loadPokemonList()
	}

	/**
	 * Loads a page of Pokemon list data.
	 *
	 * Updates the UI state to reflect the loading status and result of the operation.
	 * Uses [currentOffset] and [pageSize] for pagination.
	 */
	fun loadPokemonList() {
		viewModelScope.launch {
			_uiState.value = PokemonListUiState.Loading
			when (val result = repository.getPokemonList(currentOffset, pageSize)) {
				is Result.Success -> {
					_uiState.value = PokemonListUiState.Success(
						pokemons = result.data.results,
						isNextPageAvailable = result.data.next != null,
						isPreviousPageAvailable = result.data.previous != null,
						totalCount = result.data.count
					)
				}

				is Result.Error -> {
					_uiState.value = PokemonListUiState.Error(result.exception)
				}
			}
		}
	}

	/**
	 * Loads the next page of Pokemon if available.
	 *
	 * Increments the [currentOffset] by [pageSize] and loads the next set of Pokemon
	 * if there are more items available.
	 */
	fun loadNextPage() {
		if (currentOffset + pageSize < ((_uiState.value as? PokemonListUiState.Success)?.totalCount
				?: 0)
		) {
			currentOffset += pageSize
			loadPokemonList()
		}
	}

	/**
	 * Loads the previous page of Pokemon if available.
	 *
	 * Decrements the [currentOffset] by [pageSize] and loads the previous set of Pokemon
	 * if not at the beginning of the list.
	 */
	fun loadPreviousPage() {
		if (currentOffset - pageSize >= 0) {
			currentOffset -= pageSize
			loadPokemonList()
		}
	}

	/**
	 * Refreshes the Pokemon list from the beginning.
	 *
	 * Resets pagination to the first page and reloads the Pokemon list,
	 * useful for pull-to-refresh functionality or manual refresh requests.
	 */
	fun refresh() {
		currentOffset = 0
		loadPokemonList()
	}
}
