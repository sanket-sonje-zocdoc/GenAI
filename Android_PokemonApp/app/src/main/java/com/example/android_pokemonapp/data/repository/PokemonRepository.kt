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
import javax.inject.Singleton

/**
 * Repository for managing Pokemon data operations.
 *
 * This repository acts as a single source of truth for Pokemon data in the application,
 * handling all data operations and abstracting the data sources from the rest of the app.
 * It manages communication with the Pokemon API and handles error cases appropriately.
 *
 * @property apiService The Pokemon API service for making network requests
 */
@Singleton
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
		limit: Int = Constants.POKEMON_API_PAGE_SIZE
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
	 * Retrieves detailed information about a specific Pokemon by its URL.
	 *
	 * @param url The full URL to fetch Pokemon details
	 * @return [Result] containing either a successful [Pokemon] response or an error
	 */
	suspend fun getPokemonByUrl(url: String): Result<Pokemon> {
		Log.d(TAG, "Fetching Pokemon details for URL: $url")
		return try {
			val response = apiService.getPokemonByUrl(url)
			if (response.isSuccessful) {
				response.body()?.let {
					Log.d(TAG, "Successfully fetched Pokemon details for ${it.name}")
					Result.success(it)
				} ?: run {
					Log.e(TAG, "Pokemon details response body is null for URL: $url")
					Result.error(NetworkException.UnknownError("Response body is null"))
				}
			} else {
				Log.e(TAG, "Failed to fetch Pokemon details for URL: $url. HTTP Code: ${response.code()}")
				Result.error(NetworkException.ApiError("API call failed", response.code()))
			}
		} catch (e: IOException) {
			Log.e(TAG, "Network error while fetching Pokemon details for URL: $url", e)
			Result.error(NetworkException.NoInternetConnection())
		} catch (e: HttpException) {
			Log.e(TAG, "HTTP error while fetching Pokemon details for URL: $url. Code: ${e.code()}", e)
			Result.error(NetworkException.ApiError(e.message(), e.code()))
		} catch (e: Exception) {
			Log.e(TAG, "Unexpected error while fetching Pokemon details for URL: $url", e)
			Result.error(NetworkException.UnknownError(e.message ?: "Unknown error occurred"))
		}
	}
}
