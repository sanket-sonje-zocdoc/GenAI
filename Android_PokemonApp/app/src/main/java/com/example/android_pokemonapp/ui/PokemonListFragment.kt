package com.example.android_pokemonapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.android_pokemonapp.R
import com.example.android_pokemonapp.ui.adapter.PokemonListAdapter
import com.example.android_pokemonapp.ui.state.PokemonDetailUiState
import com.example.android_pokemonapp.ui.state.PokemonListUiState
import com.example.android_pokemonapp.ui.viewmodel.PokemonDetailViewModel
import com.example.android_pokemonapp.ui.viewmodel.PokemonListViewModel
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.isActive

@AndroidEntryPoint
class PokemonListFragment : Fragment() {

	private val listViewModel: PokemonListViewModel by viewModels()
	private val detailViewModel: PokemonDetailViewModel by viewModels()
	private lateinit var recyclerView: RecyclerView
	private lateinit var progressBar: ProgressBar
	private lateinit var adapter: PokemonListAdapter
	private var loadMoreJob: Job? = null

	companion object {
		private const val SCROLL_THRESHOLD = 5
		private const val DEBOUNCE_DELAY = 300L
		fun newInstance() = PokemonListFragment()
	}

	override fun onCreateView(
		inflater: LayoutInflater,
		container: ViewGroup?,
		savedInstanceState: Bundle?
	): View? {
		return inflater.inflate(R.layout.fragment_pokemon_list, container, false)
	}

	override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
		super.onViewCreated(view, savedInstanceState)

		setupViews(view)
		setupRecyclerView()
		observeUiState()
		observeDetailUiState()
	}

	override fun onDestroyView() {
		super.onDestroyView()
		loadMoreJob?.cancel()
	}

	private fun setupViews(view: View) {
		recyclerView = view.findViewById(R.id.pokemonListRecyclerViewA11yId)
		progressBar = view.findViewById(R.id.pokemonListProgressBarA11yId)
	}

	private fun setupRecyclerView() {
		adapter = PokemonListAdapter(detailViewModel)
		recyclerView.apply {
			layoutManager = LinearLayoutManager(context)
			adapter = this@PokemonListFragment.adapter
			addOnScrollListener(object : RecyclerView.OnScrollListener() {
				override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
					super.onScrolled(recyclerView, dx, dy)

					// Only proceed if scrolling down
					if (dy <= 0) return

					val layoutManager = recyclerView.layoutManager as LinearLayoutManager
					val lastVisibleItem = layoutManager.findLastVisibleItemPosition()
					val totalItemCount = layoutManager.itemCount

					// Check if we're near the end
					if (lastVisibleItem >= totalItemCount - SCROLL_THRESHOLD) {
						loadMoreWithDebounce()
					}
				}
			})
		}
	}

	private fun loadMoreWithDebounce() {
		// Cancel any existing job
		loadMoreJob?.cancel()

		// Create a new job with debounce
		loadMoreJob = viewLifecycleOwner.lifecycleScope.launch {
			delay(DEBOUNCE_DELAY)
			if (isActive) {
				listViewModel.loadNextPage()
			}
		}
	}

	private fun observeUiState() {
		viewLifecycleOwner.lifecycleScope.launch {
			listViewModel.uiState.collect { state ->
				when (state) {
					is PokemonListUiState.Loading -> {
						progressBar.visibility = View.VISIBLE
						recyclerView.visibility = View.GONE
					}

					is PokemonListUiState.Success -> {
						progressBar.visibility = View.GONE
						recyclerView.visibility = View.VISIBLE

						if (state.isLoadingMore) {
							adapter.setLoadingMore(true)
						} else {
							adapter.setLoadingMore(false)
							// Check if this is initial load or loading more
							if (adapter.getPokemons().isEmpty()) {
								// Initial load - use setData
								adapter.setData(state.pokemons)
							} else {
								// Loading more - use appendData with only new items
								adapter.appendData(state.pokemons)
							}
						}
					}

					is PokemonListUiState.Error -> {
						progressBar.visibility = View.GONE
						adapter.setLoadingMore(false)
						Toast.makeText(context, "Error: ${state.error.message}", Toast.LENGTH_SHORT).show()
					}
				}
			}
		}
	}

	private fun observeDetailUiState() {
		viewLifecycleOwner.lifecycleScope.launch {
			detailViewModel.uiState.collect { state ->
				when (state) {
					is PokemonDetailUiState.Success -> {
						adapter.updatePokemonDetail(state.pokemon)
					}

					is PokemonDetailUiState.Error -> {
						Toast.makeText(context, "Error loading details: ${state.error.message}", Toast.LENGTH_SHORT).show()
					}

					else -> {
						// Loading state handled by ViewHolder
					}
				}
			}
		}
	}
}
