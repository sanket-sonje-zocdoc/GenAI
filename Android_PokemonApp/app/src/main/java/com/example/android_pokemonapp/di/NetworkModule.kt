package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

/**
 * Singleton object responsible for providing network-related dependencies.
 *
 * This module configures and provides Retrofit instance and API service
 * for making network requests to the Pokemon API. It uses lazy initialization
 * to ensure the dependencies are created only when needed.
 */
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

	/**
	 * Base URL for the Pokemon API
	 */
	private const val BASE_URL = "https://pokeapi.co/api/v2/"

	/**
	 * Lazily initialized Retrofit instance configured for the Pokemon API.
	 *
	 * Uses Gson for JSON serialization/deserialization and is configured
	 * with the Pokemon API base URL and logging-enabled OkHttpClient.
	 */
	@Provides
	@Singleton
	fun provideRetrofit(): Retrofit {
		return Retrofit.Builder()
			.baseUrl(BASE_URL)
			.addConverterFactory(GsonConverterFactory.create())
			.build()
	}

	/**
	 * Provides a singleton instance of the Pokemon API service.
	 *
	 * Creates and caches a Retrofit implementation of the [PokemonApiService]
	 * interface for making API calls.
	 */
	@Provides
	@Singleton
	fun providePokemonApiService(retrofit: Retrofit): PokemonApiService {
		return retrofit.create(PokemonApiService::class.java)
	}
}
