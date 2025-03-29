package com.example.android_pokemonapp.ui.adapter

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import coil.load
import coil.transform.CircleCropTransformation
import com.example.android_pokemonapp.R
import com.example.android_pokemonapp.data.model.Pokemon
import com.example.android_pokemonapp.data.model.PokemonListItem

class PokemonListViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
	private val imageContainer: View = itemView.findViewById(R.id.pokemonAvatarImageContainerA11yId)
	private val imageView: ImageView =
		imageContainer.findViewById(R.id.pokemonAvatarImageViewA11yId)
	private val loadingSpinner: View =
		imageContainer.findViewById(R.id.pokemonAvatarProgressBarA11yId)
	private val nameTextView: TextView = itemView.findViewById(R.id.pokemonNameTextViewA11yId)
	private val typeTextView: TextView = itemView.findViewById(R.id.pokemonTypeTextViewA11yId)

	fun bind(pokemonListItem: PokemonListItem, pokemon: Pokemon?) {
		if (pokemon == null) {
			// Hide type text and show loading state for image
			nameTextView.visibility = View.GONE
			typeTextView.visibility = View.GONE
			imageView.setImageResource(R.drawable.frame_pokemon_avatar)
			loadingSpinner.visibility = View.VISIBLE
			return
		}

		// Display Pokemon Name
		nameTextView.text = pokemon.name.replaceFirstChar { it.uppercase() }
		nameTextView.visibility = View.VISIBLE

		// Display Pokemon types
		val types =
			pokemon.types.joinToString("/") { it.type.name.replaceFirstChar { c -> c.uppercase() } }
		typeTextView.text = types
		typeTextView.visibility = View.VISIBLE

		// Reset image and show loading state
		imageView.setImageResource(R.drawable.frame_pokemon_avatar)
		loadingSpinner.visibility = View.VISIBLE

		// Load Pokemon sprite image using Coil
		imageView.load(pokemon.sprites.frontDefault) {
			crossfade(true)
			placeholder(R.drawable.frame_pokemon_avatar)
			transformations(CircleCropTransformation())
			listener(
				onStart = {
					loadingSpinner.visibility = View.VISIBLE
				},
				onSuccess = { _, _ ->
					loadingSpinner.visibility = View.GONE
				},
				onError = { _, _ ->
					loadingSpinner.visibility = View.GONE
					imageView.setImageResource(R.drawable.frame_pokemon_avatar)
				}
			)
		}
	}
}
