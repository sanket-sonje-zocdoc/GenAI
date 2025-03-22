package com.example.android_pokemonapp.data.util

sealed class NetworkException(message: String) : Exception(message) {
	data class NoInternetConnection(
		override val message: String = "No internet connection available"
	) : NetworkException(message)

	data class ServerError(
		override val message: String = "Server error occurred"
	) : NetworkException(message)

	data class ApiError(
		override val message: String,
		val code: Int
	) : NetworkException(message)

	data class UnknownError(
		override val message: String = "An unknown error occurred"
	) : NetworkException(message)
}
