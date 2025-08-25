//
//  ProductsByCategoryViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 25/08/25.
//

import XCTest
@testable import API_Challenge

final class ProductsByCategoryViewModelTests: XCTestCase {
    
    func test_loadProductsByCategory() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductsByCategoryViewModel(service: service)
        
        // When
        await viewModel.load(category: .smartphones, limit: 10, skip: 0)
        
        // Then
        XCTAssertFalse(viewModel.products.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadProductsByCategoryShouldFail() async throws {
        
        // Given
        let service = MockProductService(shouldFail: true)
        let viewModel = ProductsByCategoryViewModel(service: service)
        
        // When
        await viewModel.load(category: .smartphones, limit: 10, skip: 0)
        
        // Then
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_filteredProducts_respectsSearchText() {
        // Given
        let viewModel = ProductsByCategoryViewModel(service: MockProductService())
        let store: [ProductCategory: [Product]] = [
            .smartphones: [
                Product(id: 1, title: "iPhone 15",  description: "", category: "smartphones", price: 999, thumbnail: ""),
                Product(id: 2, title: "Galaxy S24", description: "", category: "smartphones", price: 899, thumbnail: ""),
                Product(id: 3, title: "Pixel 9",    description: "", category: "smartphones", price: 799, thumbnail: "")
            ]
        ]
        viewModel.products = store[.smartphones]!
        
        // When / Then: termo que encontra um item
        viewModel.searchText = "pixel"
        XCTAssertEqual(viewModel.filteredProducts.map(\.title), ["Pixel 9"])

        // When / Then: termo inexistente
        viewModel.searchText = "zzz"
        XCTAssertTrue(viewModel.filteredProducts.isEmpty)

        // When / Then: vazio devolve todos
        viewModel.searchText = "   "
        XCTAssertEqual(viewModel.filteredProducts.count, viewModel.products.count)
    }
}
