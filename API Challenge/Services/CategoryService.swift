//
//  CategoryService.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

final class CategoryService: CategoryServiceProtocol {
    private let baseURL = "https://dummyjson.com"
    
    func fetchCategories() async throws -> [ProductCategory] {
        let urlString = "\(baseURL)/products/category-list"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else { throw URLError(.badServerResponse) }
        let slugs = try JSONDecoder().decode([String].self, from: data)
        
        return slugs.compactMap(ProductCategory.init(rawValue:))
    }
}

