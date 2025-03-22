package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

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
