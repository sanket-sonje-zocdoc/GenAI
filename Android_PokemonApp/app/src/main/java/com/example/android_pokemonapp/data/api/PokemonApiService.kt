package com.example.android_pokemonapp.data.api

import com.example.android_pokemonapp.data.model.PaginatedResponse
import com.example.android_pokemonapp.data.model.Pokemon
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

/**
 * REST API service interface for interacting with the Pokemon API.
 *
 * Provides methods to fetch Pokemon data including paginated lists of Pokemon
 * and detailed information about specific Pokemon by their ID.
 *
 * @see Pokemon
 * @see PaginatedResponse
 */
interface PokemonApiService {

	/**
	 * Retrieves a paginated list of Pokemon.
	 *
	 * @property offset Number of items to skip before starting to collect the result set [0-∞]
	 * @property limit Maximum number of items to return in a single page [1-100]
	 * @return PaginatedResponse containing a list of Pokemon and pagination metadata
	 */
	@GET("pokemon")
	suspend fun getPokemonList(
		@Query("offset") offset: Int = 0,
		@Query("limit") limit: Int = 100
	): PaginatedResponse

	/**
	 * Retrieves detailed information about a specific Pokemon by its ID.
	 *
	 * @property id Unique identifier of the Pokemon [1-∞]
	 * @return Pokemon object containing detailed information about the requested Pokemon
	 */
	@GET("pokemon/{id}")
	suspend fun getPokemonById(@Path("id") id: Int): Pokemon
}
