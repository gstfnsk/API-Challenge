//
//  CategoryViewModel.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

@MainActor
@Observable
final class CategoryViewModel: CategoryViewModelProtocol {
    var featured: [ProductCategory] = [.beauty, .laptops, .tablets, .groceries]

    var categories: [ProductCategory] = []
    var searchText: String = "" {
        didSet { updateDerivedState() }
    }
    var uiState: CategoryUIState = .loading

    private let service: CategoryServiceProtocol

    init(service: CategoryServiceProtocol) {
        self.service = service
    }

    var filteredCategories: [ProductCategory] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return categories }
        return categories.filter { $0.displayName.localizedCaseInsensitiveContains(query) }
    }

    func loadCategories() async {
        uiState = .loading
        do {
            categories = try await service.fetchCategories()
            updateDerivedState()
        } catch {
            categories = []
            uiState = .error("Error to fetch Categories: \(error.localizedDescription)")
        }
    }

    private func updateDerivedState() {
        uiState = categories.isEmpty ? .loaded(isEmpty: true) : .loaded(isEmpty: filteredCategories.isEmpty)
    }
}

