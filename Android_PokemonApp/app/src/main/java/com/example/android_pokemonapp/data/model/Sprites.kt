package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

data class Sprites(
	@SerializedName("front_default")
	val frontDefault: String,

	@SerializedName("front_shiny")
	val frontShiny: String?
)
