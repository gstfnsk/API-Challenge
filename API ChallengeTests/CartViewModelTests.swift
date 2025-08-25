//
//  CartViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 25/08/25.
//

import XCTest
@testable import API_Challenge

final class CartViewModelTests: XCTestCase {
    
    func makeCartItem(productId: Int, amount: Int) -> CartItem {
        CartItem(productId: productId, amount: amount)
    }
    
    func makeProduct(id: Int, price: Double, title: String = "Item") -> Product {
        Product(id: id, title: title, description: "", category: "cat", price: price, thumbnail: "")
    }

    func test_addToCart() {
        // Given
        let dataService = MockSwiftDataService()
        let viewModel = CartViewModel(dataSource: dataService)

        // When
        viewModel.addToCart(productId: 10, amount: 1)
        
        // Then
        XCTAssertEqual(dataService.addProductCalls.count, 1)
        XCTAssertTrue(viewModel.isInCart(id: 10))
        XCTAssertEqual(viewModel.amountInCart(productId: 10), 1)
    }
    
    func test_subtractFromCart() {
        // Given
        let cartItem = makeCartItem(productId: 5, amount: 3)
        let dataService = MockSwiftDataService(initialCart: [cartItem])
        let viewModel = CartViewModel(dataSource: dataService)

        // When
        viewModel.subtractFromCart(productId: 5)
        
        // Then
        XCTAssertEqual(dataService.updateAmountCalls.count, 1)
        XCTAssertEqual(dataService.updateAmountCalls.first?.productId, 5)
        XCTAssertEqual(dataService.updateAmountCalls.first?.newAmount, 2)
        XCTAssertEqual(viewModel.amountInCart(productId: 5), 2)
    }
    
    func test_removeFromCart() {
        // Given
        let cartItem = makeCartItem(productId: 4, amount: 2)
        let dataService = MockSwiftDataService(initialCart: [cartItem])
        let viewModel = CartViewModel(dataSource: dataService)
        XCTAssertTrue(viewModel.isInCart(id: 4))

        // When
        viewModel.removeFromCart(productId: 4)

        // Then
        XCTAssertEqual(dataService.deleteFromCartCalls.count, 1)
        XCTAssertFalse(viewModel.isInCart(id: 4))
        XCTAssertTrue(viewModel.cart.isEmpty)
    }
    
    func test_calculateTotal() {
        // Given
        let items = [makeCartItem(productId: 1, amount: 2), makeCartItem(productId: 2, amount: 3)]
        let dataService = MockSwiftDataService(initialCart: items)
        let viewModel = CartViewModel(dataSource: dataService)
        viewModel.productsVM.products = [makeProduct(id: 1, price: 10), makeProduct(id: 2, price: 5)]

        // When
        let total = viewModel.calculateTotal()

        // Then
        XCTAssertEqual(total, 35.0, accuracy: 0.0001)
    }

    func test_clearCart() {
        // Given
        let items = [makeCartItem(productId: 1, amount: 1), makeCartItem(productId: 2, amount: 2)]
        let dataService = MockSwiftDataService(initialCart: items)
        let viewModel = CartViewModel(dataSource: dataService)
        XCTAssertEqual(viewModel.cart.count, 2)

        // When
        viewModel.clear()

        // Then
        XCTAssertTrue(viewModel.cart.isEmpty)
        XCTAssertEqual(dataService.deleteFromCartCalls.count, 2)
        XCTAssertTrue(dataService.cartStore.isEmpty)
    }
    
}
