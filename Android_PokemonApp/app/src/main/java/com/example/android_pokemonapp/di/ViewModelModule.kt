package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.repository.PokemonRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ViewModelComponent
import dagger.hilt.android.scopes.ViewModelScoped

@Module
@InstallIn(ViewModelComponent::class)
object ViewModelModule {

	@Provides
	@ViewModelScoped
	fun providePokemonRepository(apiService: PokemonApiService): PokemonRepository {
		return PokemonRepository(apiService)
	}
}
