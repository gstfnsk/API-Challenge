//
//  CategoryViewModel.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

@Observable
final class CategoryViewModel: CategoryViewModelProtocol {
    var categories: [ProductCategory] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: CategoryServiceProtocol
    
    init(service: CategoryServiceProtocol = CategoryService()) {
        self.service = service
    }
    
    func loadCategories() async {
        isLoading = true
        defer { isLoading = false }
        do {
            categories = try await service.fetchCategories()
            errorMessage = nil
        } catch {
            categories = []
            errorMessage = "Error to fetch Categories: \(error.localizedDescription)"
        }
    }
}

