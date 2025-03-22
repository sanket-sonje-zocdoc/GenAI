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

@HiltViewModel
class PokemonListViewModel @Inject constructor(
    private val repository: PokemonRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<PokemonListUiState>(PokemonListUiState.Loading)
    val uiState: StateFlow<PokemonListUiState> = _uiState.asStateFlow()

    private var currentOffset = 0
    private val pageSize = 20

    init {
        loadPokemonList()
    }

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

    fun loadNextPage() {
        if (currentOffset + pageSize < ((_uiState.value as? PokemonListUiState.Success)?.totalCount ?: 0)) {
            currentOffset += pageSize
            loadPokemonList()
        }
    }

    fun loadPreviousPage() {
        if (currentOffset - pageSize >= 0) {
            currentOffset -= pageSize
            loadPokemonList()
        }
    }

    fun refresh() {
        currentOffset = 0
        loadPokemonList()
    }
}
