package com.example.android_pokemonapp.data.model

import com.google.gson.annotations.SerializedName

data class PaginatedResponse(
	@SerializedName("count")
	val count: Int,

	@SerializedName("next")
	val next: String?,

	@SerializedName("previous")
	val previous: String?,

	@SerializedName("results")
	val results: List<PokemonListItem>
)
