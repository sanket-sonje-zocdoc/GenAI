package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

/**
 * Represents a Pokemon's individual statistic value.
 *
 * Contains the base value and effort value yield for a specific Pokemon statistic,
 * such as HP, Attack, Defense, Special Attack, Special Defense, or Speed.
 *
 * @property baseStat The base value of this statistic [0-255]
 * @property effort The effort value (EV) yield when defeating this Pokemon [0-3]
 * @property statInfo Reference to the type of statistic this represents
 * @see StatInfo
 */
data class Stat(
	@SerializedName("base_stat")
	val baseStat: Int,

	@SerializedName("effort")
	val effort: Int,

	@SerializedName("stat")
	val statInfo: StatInfo
)
