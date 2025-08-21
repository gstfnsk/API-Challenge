//
//  MockProductService.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 20/08/25.
//

import Foundation
@testable import API_Challenge

class MockProductService: ProductServiceProtocol {

    var shouldFail: Bool = false
    private var product: Product
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.product = Product(id: 0, title: "", description: "", category: "", price: 0, thumbnail: "")
    }
    
    func fetchProduct(number: Int) async throws -> API_Challenge.Product {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return product
        }
    }
    
    func fetchProducts() async throws -> [API_Challenge.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 2)
        } else {
            return [product]
        }

    }
    
    func fetchProducts(in category: API_Challenge.ProductCategory, limit: Int, skip: Int) async throws -> [API_Challenge.Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 3)
        } else {
            return [product]
        }
    }
    
    
}
