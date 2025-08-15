//
//  ExempleServices.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//
// MARK: - URL from API: https://dummyjson.com/docs

import Foundation

class ProductService: ProductServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    func fetchProduct(number: Int) async throws -> Product {
        let urlString: String = "\(baseURL)/products/\(number)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // MARK: Example Using the HTTP Response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let productResponse = try JSONDecoder().decode(Product.self, from: data)
        
        return productResponse
    }
    
    func fetchProducts() async throws -> [Product] {
        let urlString: String = "\(baseURL)/products?limit=50"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return response.products
    }
    
    func fetchProducts(in category: ProductCategory, limit: Int = 20, skip: Int = 0) async throws -> [Product] {
        let urlString = "\(baseURL)/products/category/\(category.rawValue)?limit=\(limit)&skip=\(skip)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
           
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
           
        let resp = try JSONDecoder().decode(ProductResponse.self, from: data)
           
        return resp.products
       }
}
