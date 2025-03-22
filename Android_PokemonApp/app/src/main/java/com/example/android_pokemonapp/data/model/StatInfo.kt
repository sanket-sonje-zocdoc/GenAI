package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a type of Pokemon statistic.
 *
 * Defines a base statistical attribute that all Pokemon possess,
 * such as HP, Attack, Defense, Special Attack, Special Defense, or Speed.
 *
 * @property name The name of the statistic (e.g., "hp", "attack", "defense")
 * @property url API endpoint URL for detailed information about this statistic
 * @see Stat
 */
data class StatInfo(
	@SerializedName("name")
	val name: String,

	@SerializedName("url")
	val url: String
)
