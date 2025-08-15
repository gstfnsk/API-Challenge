//
//  ProductsByCategoryViewModel.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 15/08/25.
//

import Foundation

@Observable
final class ProductsByCategoryViewModel: ProductsByCategoryViewModelProtocol {
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func load(category: ProductCategory, limit: Int = 24, skip: Int = 0) async {
        isLoading = true
        defer { isLoading = false }
        do {
            products = try await service.fetchProducts(in: category, limit: limit, skip: skip)
            errorMessage = nil
        } catch {
            products = []
            errorMessage = "Error to fetch Products by Category: \(error.localizedDescription)"
        }
    }
}
