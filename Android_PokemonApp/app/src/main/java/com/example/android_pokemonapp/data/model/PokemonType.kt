package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a Pokemon type classification.
 *
 * Defines a fundamental type category in the Pokemon universe, such as Fire, Water,
 * or Grass, which determines a Pokemon's strengths and weaknesses.
 *
 * @property name The name of the type (e.g., "fire", "water", "grass")
 * @property url API endpoint URL for detailed type information
 * @see PokemonTypeEntry
 */
data class PokemonType(
	@SerializedName("name")
	val name: String,

	@SerializedName("url")
	val url: String
)
