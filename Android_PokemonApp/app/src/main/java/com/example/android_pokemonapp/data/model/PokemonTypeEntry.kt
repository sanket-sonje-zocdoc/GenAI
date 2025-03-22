package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

data class PokemonTypeEntry(
	@SerializedName("slot")
	val slot: Int,

	@SerializedName("type")
	val type: PokemonType
)
