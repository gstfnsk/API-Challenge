//
//  ProductServiceProtocol.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

protocol ProductServiceProtocol {
    func fetchProduct(number: Int) async throws -> Product
    func fetchProducts() async throws -> [Product]
}
