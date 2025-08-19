//
//  FavoritesViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData

class FavoritesViewModel: Observable {
    var favorites: [Favorites] = []
    
    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        favorites = dataSource.fetchFavorites()
    }
    
    func toggleFavorite(id: Int) {
            if let isFavorite = favorites.first(where: { $0.id == id }) {
                dataSource.deleteFavorites(isFavorite)
            } else {
                // Não é favorito: adiciona
                let favorite = Favorites(id: id)
                dataSource.addFavorites(favorite)
            }
            // Atualiza
            favorites = dataSource.fetchFavorites()

            favorites.forEach { print($0.id) }
        }
}
