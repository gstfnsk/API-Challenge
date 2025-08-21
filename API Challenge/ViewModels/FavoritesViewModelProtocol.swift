//
//  FavoritesViewModelProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 21/08/25.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var favorites: [Favorites] { get set }
    func isFavorite(id: Int) -> Bool
    func toggleFavorite(id: Int)
}
