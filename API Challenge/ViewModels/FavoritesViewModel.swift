//
//  FavoritesViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData
import Combine

class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    @Published var favorites: [Favorites] = []
    @Published var searchText: String = "" {
        didSet { updateDerivedState() }
    }
    var uiState: CategoryUIState = .loading
    
    @Published var selectedProduct: Product?
    var productsVM = ProductViewModel(service: ProductService())
    
    let dataSource: SwiftDataServiceProtocol
    
    var favoriteProducts: [Product] {
        productsVM.products.filter { isFavorite(id: $0.id) }
    }
    
    var filteredFavorites: [Product] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return favoriteProducts }
        return favoriteProducts.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
    
    init(dataSource: SwiftDataServiceProtocol) {
        self.dataSource = dataSource
        favorites = dataSource.fetchFavorites()
    }
    
    func isFavorite(id: Int) -> Bool {
            favorites.contains { $0.id == id }
    }
    
    func toggleFavorite(id: Int) {
            if let isFavorite = favorites.first(where: { $0.id == id }) {
                dataSource.deleteFavorites(isFavorite)
            } else {
                let favorite = Favorites(id: id)
                dataSource.addFavorites(favorite)
            }
            favorites = dataSource.fetchFavorites()

            favorites.forEach { print($0.id) }
    }
    
    private func updateDerivedState() {
        uiState = favorites.isEmpty ? .loaded(isEmpty: true) : .loaded(isEmpty: filteredFavorites.isEmpty)
    }
}
