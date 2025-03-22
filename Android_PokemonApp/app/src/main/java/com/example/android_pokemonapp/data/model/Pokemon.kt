package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a complete Pokemon entity with all its attributes.
 *
 * Contains comprehensive information about a Pokemon including its physical characteristics,
 * battle statistics, type affiliations, and visual representations as received from the PokemonAPI.
 *
 * @property id Unique identifier for the Pokemon [1-898]
 * @property name The official name of the Pokemon
 * @property height The Pokemon's height in decimeters [1dm = 10cm]
 * @property weight The Pokemon's weight in hectograms [1hg = 100g]
 * @property types List of types this Pokemon belongs to (e.g., Fire, Water)
 * @property stats List of base statistics including HP, Attack, Defense, etc.
 * @property sprites Collection of URLs for different Pokemon sprite images
 * @see PokemonTypeEntry
 * @see Stat
 * @see Sprites
 */
data class Pokemon(
	@SerializedName("id")
	val id: Int,

	@SerializedName("name")
	val name: String,

	@SerializedName("height")
	val height: Int,

	@SerializedName("weight")
	val weight: Int,

	@SerializedName("types")
	val types: List<PokemonTypeEntry>,

	@SerializedName("stats")
	val stats: List<Stat>,

	@SerializedName("sprites")
	val sprites: Sprites
)
