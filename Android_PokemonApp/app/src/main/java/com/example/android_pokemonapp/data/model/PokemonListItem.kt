package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

data class PokemonListItem(
	@SerializedName("id")
	val id: String,

	@SerializedName("name")
	val name: String,

	@SerializedName("url")
	val url: String
)
