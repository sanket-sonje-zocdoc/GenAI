package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a collection of Pokemon sprite images.
 *
 * Contains URLs for different visual representations of a Pokemon,
 * including its default appearance and shiny variant.
 *
 * @property frontDefault URL for the default front-facing sprite image
 * @property frontShiny URL for the shiny variant's front-facing sprite image, null if unavailable
 */
data class Sprites(
	@SerializedName("front_default")
	val frontDefault: String,

	@SerializedName("front_shiny")
	val frontShiny: String?
)
