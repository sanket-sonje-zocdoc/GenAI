package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a paginated response from the PokemonAPI.
 *
 * Handles the pagination of Pokemon list data, providing navigation links and
 * metadata for traversing through the complete Pokemon collection.
 *
 * @property count Total number of available Pokemon in the API
 * @property next URL for the next page of results, null if this is the last page
 * @property previous URL for the previous page of results, null if this is the first page
 * @property results List of Pokemon items for the current page
 * @see PokemonListItem
 */
data class PaginatedResponse(
	@SerializedName("count")
	val count: Int,

	@SerializedName("next")
	val next: String?,

	@SerializedName("previous")
	val previous: String?,

	@SerializedName("results")
	val results: List<PokemonListItem>
)
