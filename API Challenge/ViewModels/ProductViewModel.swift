//
//  ProductViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import Foundation

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
    
    func favoritedProducts() -> [Product] {
        products.filter { $0.isFavorite }
    }
    
//    func productsInCart(products: [Product]) -> {
//        
//    }
}
