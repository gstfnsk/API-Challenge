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
    
    func addFavoriteById(id: Int) {
        let favorite = Favorites(id: id)
        dataSource.addFavorites(favorite)
        favorites = dataSource.fetchFavorites()
        
        favorites.forEach { favorite in
            print(favorite.id)
        }
        
        
    }
    
}
