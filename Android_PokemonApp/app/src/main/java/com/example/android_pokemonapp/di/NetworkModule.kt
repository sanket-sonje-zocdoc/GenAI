package com.example.android_pokemonapp.di

import com.example.android_pokemonapp.data.api.PokemonApiService
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object NetworkModule {
	private const val BASE_URL = "https://pokeapi.co/api/v2/"

	private val retrofit: Retrofit by lazy {
		Retrofit.Builder()
			.baseUrl(BASE_URL)
			.addConverterFactory(GsonConverterFactory.create())
			.build()
	}

	val pokemonApiService: PokemonApiService by lazy {
		retrofit.create(PokemonApiService::class.java)
	}
}
