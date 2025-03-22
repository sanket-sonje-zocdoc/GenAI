package com.example.android_pokemonapp.data.repository

import com.example.android_pokemonapp.data.api.PokemonApiService
import com.example.android_pokemonapp.data.model.PaginatedResponse
import com.example.android_pokemonapp.data.model.Pokemon
import com.example.android_pokemonapp.data.util.NetworkException
import com.example.android_pokemonapp.data.util.Result
import retrofit2.HttpException
import java.io.IOException
import javax.inject.Inject

class PokemonRepository @Inject constructor(
	private val apiService: PokemonApiService
) {
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
