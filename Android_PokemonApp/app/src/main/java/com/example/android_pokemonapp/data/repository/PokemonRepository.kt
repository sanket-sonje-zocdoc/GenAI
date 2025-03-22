package com.example.android_pokemonapp.data.repository

import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.model.PaginatedResponse
import com.example.android_pokemonapp.data.model.Pokemon
import com.example.android_pokemonapp.data.util.NetworkException
import com.example.android_pokemonapp.data.util.Result
import retrofit2.HttpException
import java.io.IOException
import javax.inject.Inject

/**
 * Repository for managing Pokemon data operations.
 *
 * This repository acts as a single source of truth for Pokemon data in the application,
 * handling all data operations and abstracting the data sources from the rest of the app.
 * It manages communication with the Pokemon API and handles error cases appropriately.
 *
 * @property apiService The Pokemon API service for making network requests
 */
class PokemonRepository @Inject constructor(
	private val apiService: PokemonApiService
) {
	/**
	 * Retrieves a paginated list of Pokemon.
	 *
	 * @param offset The number of items to skip before starting to collect the result set [default: 0]
	 * @param limit The maximum number of items to return [default: 100]
	 * @return [Result] containing either a successful [PaginatedResponse] or an error
	 */
	suspend fun getPokemonList(offset: Int = 0, limit: Int = 100): Result<PaginatedResponse> {
		return try {
			val response = apiService.getPokemonList(offset, limit)
			Result.success(response)
		} catch (e: IOException) {
			Result.error(NetworkException.NoInternetConnection())
		} catch (e: HttpException) {
			Result.error(NetworkException.ApiError(e.message(), e.code()))
		} catch (e: Exception) {
			Result.error(NetworkException.UnknownError(e.message ?: "Unknown error occurred"))
		}
	}

	/**
	 * Retrieves detailed information about a specific Pokemon by its ID.
	 *
	 * @param id The unique identifier of the Pokemon
	 * @return [Result] containing either a successful [Pokemon] response or an error
	 */
	suspend fun getPokemonById(id: Int): Result<Pokemon> {
		return try {
			val response = apiService.getPokemonById(id)
			Result.success(response)
		} catch (e: IOException) {
			Result.error(NetworkException.NoInternetConnection())
		} catch (e: HttpException) {
			Result.error(NetworkException.ApiError(e.message(), e.code()))
		} catch (e: Exception) {
			Result.error(NetworkException.UnknownError(e.message ?: "Unknown error occurred"))
		}
	}
}
