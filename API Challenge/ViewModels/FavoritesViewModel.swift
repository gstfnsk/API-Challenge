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
    
    private let dataSource: SwiftDataServiceProtocol
    
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
    
    
}
