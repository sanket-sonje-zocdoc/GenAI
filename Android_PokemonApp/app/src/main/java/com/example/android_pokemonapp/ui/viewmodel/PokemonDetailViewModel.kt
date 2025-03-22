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

@HiltViewModel
class PokemonDetailViewModel @Inject constructor(
	private val repository: PokemonRepository,
	private val savedStateHandle: SavedStateHandle
) : ViewModel() {

	private val _uiState = MutableStateFlow<PokemonDetailUiState>(PokemonDetailUiState.Loading)
	val uiState: StateFlow<PokemonDetailUiState> = _uiState.asStateFlow()

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

	fun refresh(pokemonId: Int) {
		loadPokemonDetail(pokemonId)
	}
}
