//
//  ProductsByCategoryViewModelProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 15/08/25.
//

import Foundation

protocol ProductsByCategoryViewModelProtocol {
    var products: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var searchText: String { get set }
    var filteredProducts: [Product] { get }
    func load(category: ProductCategory, limit: Int, skip: Int) async
    func syncFavorites(with favorites: [Favorites])
}
