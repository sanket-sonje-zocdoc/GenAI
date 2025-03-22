package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a lightweight Pokemon entry in a list.
 *
 * Contains basic information about a Pokemon used in list views and
 * provides a URL to fetch detailed information when needed.
 *
 * @property id Unique identifier of the Pokemon
 * @property name Display name of the Pokemon
 * @property url API endpoint URL to fetch complete Pokemon details
 * @see Pokemon
 */
data class PokemonListItem(
	@SerializedName("id")
	val id: String,

	@SerializedName("name")
	val name: String,

	@SerializedName("url")
	val url: String
)
