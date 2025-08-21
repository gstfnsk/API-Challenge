//
//  FavoritesViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 21/08/25.
//

import XCTest
@testable import API_Challenge

final class FavoritesViewModelTests: XCTestCase {
    
    func test_isFavorite() {
     
        // Given
        let dataSource = MockSwiftDataService(initialFavorites: [Favorites(id: 1)])
        let viewModel = FavoritesViewModel(dataSource: dataSource)
        
        // When
        let result = viewModel.isFavorite(id: 1)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isNotFavorite() {
        
        // Given
        let dataSource = MockSwiftDataService(initialFavorites: [Favorites(id: 1)])
        let viewModel = FavoritesViewModel(dataSource: dataSource)
        
        // When
        let result = viewModel.isFavorite(id: 2)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_toggleFavoriteAdd() {
        
        // Given
        let dataSource = MockSwiftDataService(initialFavorites: [])
        let viewModel = FavoritesViewModel(dataSource: dataSource)
        
        // When
        viewModel.toggleFavorite(id: 1)
        
        // Then
        XCTAssertTrue(viewModel.isFavorite(id: 1))
        XCTAssertEqual(viewModel.favorites.map(\.id), [1])
    }
    
    func test_toggleFavoriteRemove() {
        
        // Given
        let dataSource = MockSwiftDataService(initialFavorites: [Favorites(id: 1)])
        let viewModel = FavoritesViewModel(dataSource: dataSource)
        
        // When
        viewModel.toggleFavorite(id: 1)
        
        // Then
        XCTAssertFalse(viewModel.isFavorite(id: 1))
        XCTAssertTrue(viewModel.favorites.isEmpty)
    }
    
}
