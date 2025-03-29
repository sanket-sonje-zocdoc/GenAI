package com.example.android_pokemonapp.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.android_pokemonapp.R
import com.example.android_pokemonapp.data.model.Pokemon
import com.example.android_pokemonapp.data.model.PokemonListItem
import com.example.android_pokemonapp.ui.viewmodel.PokemonDetailViewModel

class PokemonListAdapter(
	private val detailViewModel: PokemonDetailViewModel
) : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

	private var pokemonList: MutableList<PokemonListItem> = mutableListOf()
	private val pokemonDetails = mutableMapOf<String, Pokemon>()
	private var isLoadingMore = false

	companion object {
		private const val VIEW_TYPE_ITEM = 0
		private const val VIEW_TYPE_LOADING = 1
	}

	override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
		return when (viewType) {
			VIEW_TYPE_ITEM -> {
				val view = LayoutInflater.from(parent.context)
					.inflate(R.layout.item_pokemon, parent, false)
				PokemonListViewHolder(view)
			}

			VIEW_TYPE_LOADING -> {
				val view = LayoutInflater.from(parent.context)
					.inflate(R.layout.core_pokemon_item_loader, parent, false)
				PokemonLoadingViewHolder(view)
			}

			else -> throw IllegalArgumentException("Unknown view type: $viewType")
		}
	}

	override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
		when (holder) {
			is PokemonListViewHolder -> {
				val pokemonListItem = pokemonList[position]
				val currentDetails = pokemonDetails[pokemonListItem.name]
				holder.bind(pokemonListItem, currentDetails)

				if (currentDetails == null) {
					detailViewModel.loadPokemonDetail(pokemonListItem.url)
				}
			}

			is PokemonLoadingViewHolder -> {
				// NO-OP
			}
		}
	}

	override fun getItemViewType(position: Int): Int {
		return if (position == pokemonList.size && isLoadingMore) {
			VIEW_TYPE_LOADING
		} else {
			VIEW_TYPE_ITEM
		}
	}

	override fun getItemCount(): Int = pokemonList.size + if (isLoadingMore) 1 else 0

	fun setData(newPokemonList: List<PokemonListItem>) {
		pokemonList.clear()
		pokemonList.addAll(newPokemonList)
		notifyDataSetChanged()
	}

	fun appendData(additionalPokemons: List<PokemonListItem>) {
		val startPosition = pokemonList.size
		pokemonList.addAll(additionalPokemons)
		notifyItemRangeInserted(startPosition, additionalPokemons.size)
	}

	fun setLoadingMore(loading: Boolean) {
		if (isLoadingMore != loading) {
			isLoadingMore = loading
			if (loading) {
				notifyItemInserted(itemCount)
			} else {
				notifyItemRemoved(itemCount)
			}
		}
	}

	fun updatePokemonDetail(pokemon: Pokemon) {
		pokemonDetails[pokemon.name] = pokemon
		val position = pokemonList.indexOfFirst { it.name == pokemon.name }
		if (position != -1) {
			notifyItemChanged(position)
		}
	}

	fun getPokemons(): List<PokemonListItem> = pokemonList.toList()
}
