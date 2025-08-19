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
        
        // Add dummy expenses to the SwiftData to see if fetching data is works
        let dummyFavorites = Favorites.dummyFavorites
        for favorite in dummyFavorites {
            dataSource.addFavorites(favorite)
        }
        
        favorites = dataSource.fetchFavorites()
    }
    
    func addSampleFavorite() {
        let favorite = Favorites(id: 100)
        dataSource.addFavorites(favorite)
        
        // Manually fetch the latest expenses after add new expense
        favorites = dataSource.fetchFavorites()
    }
}


extension Favorites {
    static let dummyFavorites: [Favorites] = [
        Favorites(id: 1),
        
        Favorites(id: 2),
        
        Favorites(id: 3),
    ]
}
