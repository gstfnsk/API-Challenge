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
    var selectedProduct: Product?
    
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
 
}

