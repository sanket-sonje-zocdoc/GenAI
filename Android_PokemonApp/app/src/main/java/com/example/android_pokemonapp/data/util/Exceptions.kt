package com.example.android_pokemonapp.data.util

/**
 * Represents network-related exceptions that can occur during API operations.
 *
 * This sealed class hierarchy provides a type-safe way to handle different
 * categories of network failures that may occur when interacting with the Pokemon API.
 *
 * @property message The error message describing the nature of the exception
 */
sealed class NetworkException(message: String) : Exception(message) {

	/**
	 * Indicates that the device has no internet connectivity.
	 *
	 * @property message The error message [default: "No internet connection available"]
	 */
	data class NoInternetConnection(
		override val message: String = "No internet connection available"
	) : NetworkException(message)

	/**
	 * Indicates that the server encountered an error while processing the request.
	 *
	 * @property message The error message [default: "Server error occurred"]
	 */
	data class ServerError(
		override val message: String = "Server error occurred"
	) : NetworkException(message)

	/**
	 * Represents an error returned by the API with a specific error code.
	 *
	 * @property message The error message from the API
	 * @property code The HTTP status code returned by the API
	 */
	data class ApiError(
		override val message: String,
		val code: Int
	) : NetworkException(message)

	/**
	 * Represents an unexpected error that doesn't fall into other categories.
	 *
	 * @property message The error message [default: "An unknown error occurred"]
	 */
	data class UnknownError(
		override val message: String = "An unknown error occurred"
	) : NetworkException(message)
}
