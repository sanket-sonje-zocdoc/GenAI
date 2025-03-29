package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.repository.PokemonRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * Dagger Hilt module for providing ViewModel-scoped dependencies.
 *
 * This module is installed in the [ViewModelComponent] and provides dependencies
 * that should be scoped to the ViewModel lifecycle. All dependencies provided by
 * this module will be created when a ViewModel is created and destroyed when the
 * ViewModel is cleared.
 */
@Module
@InstallIn(SingletonComponent::class)
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
	@Singleton
	fun providePokemonRepository(apiService: PokemonApiService): PokemonRepository {
		return PokemonRepository(apiService)
	}
}
