//
//  FavoritesViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 21/08/25.
//

import XCTest
@testable import API_Challenge

final class FavoritesViewModelTests: XCTestCase {
    
    private func makeProduct(id: Int, title: String, price: Double = 10) -> Product {
        Product(id: id, title: title, description: "", category: "cat", price: price, thumbnail: "")
    }
    
    
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
    
    func test_filteredFavorites_trimsAndIsCaseInsensitive() {
        
        // Given
        let p1 = makeProduct(id: 1, title: "Copo Térmico")
        let p2 = makeProduct(id: 2, title: "Garrafa")
        let dataSource = MockSwiftDataService(initialFavorites: [Favorites(id: 1), Favorites(id: 2)])
        let vm = FavoritesViewModel(dataSource: dataSource).setProductsForTesting([p1, p2])
            
        // When
        vm.searchText = "   térMICO "

        // Then
        XCTAssertEqual(vm.filteredFavorites.count, 1)
        XCTAssertEqual(vm.filteredFavorites.first?.title, "Copo Térmico")
    }
}

extension FavoritesViewModel {
    func setProductsForTesting(_ products: [Product]) -> FavoritesViewModel {
        self.productsVM.products = products
        return self
    }
}
