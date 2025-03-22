package com.example.android_pokemonapp.data.api

import com.example.android_pokemonapp.data.model.PaginatedResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface PokemonApiService {

	@GET("pokemon")
	suspend fun getPokemonList(
		@Query("offset") offset: Int = 0,
		@Query("limit") limit: Int = 100
	): PaginatedResponse
}
