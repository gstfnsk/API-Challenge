//
//  CategoryViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 22/08/25.
//

import XCTest
@testable import API_Challenge

@MainActor
final class CategoryViewModelTests: XCTestCase {
    
    private func makeCategories() -> [ProductCategory] {
        return [.smartphones, .laptops]
    }
    
    func test_fetchCategories() async throws {
        
        // Given
        let categories: [ProductCategory] = makeCategories()
        let service = MockCategoryService(categories: categories)
        let viewModel = CategoryViewModel(service: service)
        
        // When
        await viewModel.loadCategories()
        
        // Then
        XCTAssertTrue(!viewModel.categories.isEmpty)
        XCTAssertEqual(viewModel.categories.count, categories.count)
    }
    
    func test_fetchCategoriesShouldFail() async throws {
        
        // Given
        let service = MockCategoryService(shouldFail: true)
        let viewModel = CategoryViewModel(service: service)
                
        // When
        await viewModel.loadCategories()
                
        // Then
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
}
