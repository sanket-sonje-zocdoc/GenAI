package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a Pokemon's type assignment with priority.
 *
 * Links a Pokemon to its type classification and specifies the slot number,
 * which determines if it's the primary or secondary type.
 *
 * @property slot Position of this type in the Pokemon's type list [1-2]
 * @property type The type classification details
 * @see PokemonType
 */
data class PokemonTypeEntry(
	@SerializedName("slot")
	val slot: Int,

	@SerializedName("type")
	val type: PokemonType
)
