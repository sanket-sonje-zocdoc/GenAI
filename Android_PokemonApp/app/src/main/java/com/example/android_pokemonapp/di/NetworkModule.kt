package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Singleton object responsible for providing network-related dependencies.
 *
 * This module configures and provides Retrofit instance and API service
 * for making network requests to the Pokemon API. It uses lazy initialization
 * to ensure the dependencies are created only when needed.
 */
object NetworkModule {

	/** Base URL for the Pokemon API */
	private const val BASE_URL = "https://pokeapi.co/api/v2/"

	/**
	 * Lazily initialized Retrofit instance configured for the Pokemon API.
	 *
	 * Uses Gson for JSON serialization/deserialization and is configured
	 * with the Pokemon API base URL and logging-enabled OkHttpClient.
	 */
	private val retrofit: Retrofit by lazy {
		Retrofit.Builder()
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
	val pokemonApiService: PokemonApiService by lazy {
		retrofit.create(PokemonApiService::class.java)
	}
}
