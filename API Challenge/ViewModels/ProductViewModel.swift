//
//  ProductViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import Foundation
import SwiftData

@Observable
class ProductViewModel: ProductViewModelProtocol {
    var product: Product?
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func syncFavorites(with favorites: [Favorites]) {
            let ids = Set(favorites.map(\.id))
            for i in products.indices {
                products[i].isFavorite = ids.contains(products[i].id)
            }
            if let p = product {
                var copy = p
                copy.isFavorite = ids.contains(p.id)
                product = copy
            }
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            product = try await service.fetchProduct(number: 2)
            products = try await service.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
 
}
