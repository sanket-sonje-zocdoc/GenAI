package com.example.android_pokemonapp.ui.viewmodel

import android.util.Log
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

	private var currentOffset = 0
	private val pageSize = 20
	private var isLoadingMore = false
	private var hasMoreItems = true

	companion object {
		private const val TAG = "PokemonListViewModel"
	}

	init {
		Log.d(TAG, "ViewModel initialized, loading initial Pokemon list")
		loadInitialPokemonList()
	}

	override fun onCleared() {
		super.onCleared()
		Log.d(TAG, "ViewModel cleared")
	}

	private fun loadInitialPokemonList() {
		Log.d(TAG, "Loading initial Pokemon list")
		viewModelScope.launch {
			_uiState.value = PokemonListUiState.Loading
			Log.d(TAG, "State changed to Loading")

			when (val result = repository.getPokemonList(0, pageSize)) {
				is Result.Success -> {
					Log.d(
						TAG,
						"Successfully loaded initial Pokemon list. Count: ${result.data.count}"
					)

					currentOffset = pageSize
					hasMoreItems = result.data.next != null
					_uiState.value = PokemonListUiState.Success(
						pokemons = result.data.results,
						isNextPageAvailable = hasMoreItems,
						isPreviousPageAvailable = false,
						totalCount = result.data.count,
						isLoadingMore = false
					)
				}

				is Result.Error -> {
					Log.e(TAG, "Failed to load initial Pokemon list", result.exception)
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
		if (isLoadingMore || !hasMoreItems) return

		val currentState = _uiState.value as? PokemonListUiState.Success ?: return

		viewModelScope.launch {
			isLoadingMore = true
			_uiState.value = currentState.copy(isLoadingMore = true)

			when (val result = repository.getPokemonList(currentOffset, pageSize)) {
				is Result.Success -> {
					currentOffset += pageSize
					hasMoreItems = result.data.next != null

					_uiState.value = PokemonListUiState.Success(
						pokemons = result.data.results,
						isNextPageAvailable = hasMoreItems,
						isPreviousPageAvailable = currentOffset > 0,
						totalCount = result.data.count,
						isLoadingMore = false
					)
					isLoadingMore = false
				}

				is Result.Error -> {
					Log.e(TAG, "Failed to load next page", result.exception)
					_uiState.value = currentState.copy(isLoadingMore = false)
					isLoadingMore = false
				}
			}
		}
	}
}
