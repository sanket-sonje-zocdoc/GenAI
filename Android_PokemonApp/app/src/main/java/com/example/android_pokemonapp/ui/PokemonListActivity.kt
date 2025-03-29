package com.example.android_pokemonapp.ui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.android_pokemonapp.R
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class PokemonListActivity : AppCompatActivity() {

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_pokemon_list)

		if (savedInstanceState == null) {
			supportFragmentManager.beginTransaction()
				.replace(R.id.pokemonListActivityA11yId, PokemonListFragment.newInstance())
				.commit()
		}
	}
}
