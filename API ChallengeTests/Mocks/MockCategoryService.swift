//
//  MockCategoryService.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 22/08/25.
//

import Foundation
@testable import API_Challenge

class MockCategoryService: CategoryServiceProtocol {

    var shouldFail: Bool = false
    private var categories: [ProductCategory]
    
    init (shouldFail: Bool = false, categories: [ProductCategory] = []) {
        self.shouldFail = shouldFail
        self.categories = categories
    }
    
    func fetchCategories() async throws -> [ProductCategory] {
        if shouldFail {
            throw NSError(domain: #function, code: 4)
        } else {
            return categories
        }
    }
    
}
