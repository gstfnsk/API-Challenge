//
//  API_ChallengeTests.swift
//  API ChallengeTests
//
//  Created by Enzo Tonatto on 20/08/25.
//

import XCTest
@testable import API_Challenge

final class ProductViewModelTests: XCTestCase {

    func test_fetchCharacters() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service)
        
        
        // When
        await viewModel.loadProducts()
        
        
        // Then
        XCTAssertTrue(!viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.product)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_fetchCharactersShouldFail() async throws {
        
        // Given
        let service = MockProductService(shouldFail: true)
        let viewModel = ProductViewModel(service: service)
        
        // When
        await viewModel.loadProducts()
        
        
        // Then
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNil(viewModel.product)
        XCTAssertNotNil(viewModel.errorMessage)
        
    }
    
    func test_syncFavorites() {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service)
        viewModel.products = [Product(id: 0, title: "", description: "", category: "", price: 0, thumbnail: "", isFavorite: false)]
        let favorites = [Favorites(id: 0)]
        
        // When
        viewModel.syncFavorites(with: favorites)
        
        // Then
        XCTAssertTrue(viewModel.products.first(where: { $0.id == 0 })?.isFavorite == true)
    }
    
}
