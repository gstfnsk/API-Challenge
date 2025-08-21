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
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    var filteredProducts: [Product] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return products }
        return products.filter { $0.title.localizedStandardContains(query) }
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

