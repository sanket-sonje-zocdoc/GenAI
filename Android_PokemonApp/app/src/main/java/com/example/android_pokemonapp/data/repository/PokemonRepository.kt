package com.example.android_pokemonapp.data.repository

import android.util.Log
import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.model.PaginatedResponse
import com.example.android_pokemonapp.data.model.Pokemon
import com.example.android_pokemonapp.data.util.NetworkException
import com.example.android_pokemonapp.data.util.Result
import com.example.android_pokemonapp.utils.Constants
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
	companion object {
		private const val TAG = "PokemonRepository"
	}

	/**
	 * Retrieves a paginated list of Pokemon.
	 *
	 * @param offset The number of items to skip before starting to collect the result set [default: 0]
	 * @param limit The maximum number of items to return [default: 100]
	 * @return [Result] containing either a successful [PaginatedResponse] or an error
	 */
	suspend fun getPokemonList(
		offset: Int = 0,
		limit: Int = Constants.POKEMON_API_LIMIT
	): Result<PaginatedResponse> {
		Log.d(TAG, "Fetching Pokemon list with offset: $offset, limit: $limit")
		return try {
			val response = apiService.getPokemonList(offset, limit)
			if (response.isSuccessful) {
				response.body()?.let {
					Log.d(TAG, "Successfully fetched Pokemon list. Total count: ${it.count}")
					Result.success(it)
				} ?: run {
					Log.e(TAG, "Pokemon list response body is null")
					Result.error(NetworkException.UnknownError("Response body is null"))
				}
			} else {
				Log.e(TAG, "Failed to fetch Pokemon list. HTTP Code: ${response.code()}")
				Result.error(NetworkException.ApiError("API call failed", response.code()))
			}
		} catch (e: IOException) {
			Log.e(TAG, "Network error while fetching Pokemon list", e)
			Result.error(NetworkException.NoInternetConnection())
		} catch (e: HttpException) {
			Log.e(TAG, "HTTP error while fetching Pokemon list. Code: ${e.code()}", e)
			Result.error(NetworkException.ApiError(e.message(), e.code()))
		} catch (e: Exception) {
			Log.e(TAG, "Unexpected error while fetching Pokemon list", e)
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
		Log.d(TAG, "Fetching Pokemon details for ID: $id")
		return try {
			val response = apiService.getPokemonById(id)
			if (response.isSuccessful) {
				response.body()?.let {
					Log.d(TAG, "Successfully fetched Pokemon details for ${it.name} (ID: $id)")
					Result.success(it)
				} ?: run {
					Log.e(TAG, "Pokemon details response body is null for ID: $id")
					Result.error(NetworkException.UnknownError("Response body is null"))
				}
			} else {
				Log.e(TAG, "Failed to fetch Pokemon details for ID: $id. HTTP Code: ${response.code()}")
				Result.error(NetworkException.ApiError("API call failed", response.code()))
			}
		} catch (e: IOException) {
			Log.e(TAG, "Network error while fetching Pokemon details for ID: $id", e)
			Result.error(NetworkException.NoInternetConnection())
		} catch (e: HttpException) {
			Log.e(TAG, "HTTP error while fetching Pokemon details for ID: $id. Code: ${e.code()}", e)
			Result.error(NetworkException.ApiError(e.message(), e.code()))
		} catch (e: Exception) {
			Log.e(TAG, "Unexpected error while fetching Pokemon details for ID: $id", e)
			Result.error(NetworkException.UnknownError(e.message ?: "Unknown error occurred"))
		}
	}
}
