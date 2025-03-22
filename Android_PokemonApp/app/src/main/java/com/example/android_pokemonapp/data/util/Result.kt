package com.example.android_pokemonapp.data.util

/**
 * A generic class that holds a value with its loading status.
 *
 * Represents a discriminated union that encapsulates successful outcome with a value of type [T]
 * or a failure with an exception. This is used to handle network responses and other operations
 * that can fail.
 *
 * @param T The type of successful result this Result can contain
 */
sealed class Result<out T> {

	/**
	 * Represents successful execution of an operation.
	 *
	 * @property data The data returned from the successful operation
	 */
	data class Success<T>(val data: T) : Result<T>()

	/**
	 * Represents failed execution of an operation.
	 *
	 * @property exception The exception that caused the operation to fail
	 */
	data class Error(val exception: Exception) : Result<Nothing>()

	companion object {
		/**
		 * Creates a successful Result instance.
		 *
		 * @param data The data to be wrapped in a Success instance
		 * @return A Result.Success instance containing the provided data
		 */
		fun <T> success(data: T): Result<T> = Success(data)

		/**
		 * Creates a failed Result instance.
		 *
		 * @param exception The exception that caused the failure
		 * @return A Result.Error instance containing the provided exception
		 */
		fun error(exception: Exception): Result<Nothing> = Error(exception)
	}
}
