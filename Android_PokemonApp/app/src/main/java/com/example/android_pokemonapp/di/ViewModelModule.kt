package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.repository.PokemonRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ViewModelComponent
import dagger.hilt.android.scopes.ViewModelScoped

/**
 * Dagger Hilt module for providing ViewModel-scoped dependencies.
 *
 * This module is installed in the [ViewModelComponent] and provides dependencies
 * that should be scoped to the ViewModel lifecycle. All dependencies provided by
 * this module will be created when a ViewModel is created and destroyed when the
 * ViewModel is cleared.
 */
@Module
@InstallIn(ViewModelComponent::class)
object ViewModelModule {

	/**
	 * Provides a ViewModel-scoped instance of [PokemonRepository].
	 *
	 * Creates a new instance of [PokemonRepository] for each ViewModel that requires it.
	 * The repository instance will be retained as long as the ViewModel exists.
	 *
	 * @param apiService The Pokemon API service instance to be injected into the repository
	 * @return A new instance of [PokemonRepository]
	 */
	@Provides
	@ViewModelScoped
	fun providePokemonRepository(apiService: PokemonApiService): PokemonRepository {
		return PokemonRepository(apiService)
	}
}
