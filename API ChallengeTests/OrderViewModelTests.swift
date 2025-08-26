//
//  OrderViewModelTests.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 25/08/25.
//

import XCTest
@testable import API_Challenge

final class OrderViewModelTests: XCTestCase {
    
    func makeProduct(id: Int = 1, title: String = "Item", price: Double = 9.99) -> Product {
        Product(id: id, title: title, description: "", category: "cat", price: price, thumbnail: "")
    }
    
    func test_placeOrder() {
        
        // Given
        let dataService = MockSwiftDataService()
        let viewModel = OrderViewModel(dataSource: dataService)
        let product = makeProduct(id: 42, title: "Teste", price: 99.9)
        
        // When
        viewModel.placeOrder(from: product)
        
        // Then
        XCTAssertEqual(dataService.addOrderCalls.count, 1)
        XCTAssertEqual(viewModel.orders.count, 1)
        let o = try! XCTUnwrap(viewModel.orders.first)
        XCTAssertEqual(o.productId, 42)
        XCTAssertEqual(o.title, "Teste")
        XCTAssertEqual(o.price, 99.9, accuracy: 0.0001)
        
    }
    
    func test_deleteOrder_removesAndRefreshes() {
        
        // Given
        let product1 = makeProduct(id: 1, title: "A", price: 10)
        let product2 = makeProduct(id: 2, title: "B", price: 20)
        let order1 = Order(product: product1)
        let order2 = Order(product: product2)
        let dataService = MockSwiftDataService(initialOrders: [order1, order2])
        let viewModel = OrderViewModel(dataSource: dataService)

        // When
        viewModel.deleteOrder(order1)

        // Then
        XCTAssertEqual(dataService.deleteOrderCalls.count, 1)
        XCTAssertEqual(viewModel.orders.count, 1)
        XCTAssertEqual(viewModel.orders.first?.productId, 2)
    }

    func test_refresh_readsFromDataSource() {
        
        // Given
        let dataService = MockSwiftDataService()
        let viewModel = OrderViewModel(dataSource: dataService)
        XCTAssertTrue(viewModel.orders.isEmpty)
        let product = makeProduct(id: 7, title: "X", price: 5)
        dataService.ordersStore = [Order(product: product, date: Date(timeIntervalSince1970: 300))]

        // When
        viewModel.refresh()

        // Then
        XCTAssertEqual(viewModel.orders.count, 1)
        XCTAssertEqual(viewModel.orders.first?.productId, 7)
        XCTAssertGreaterThanOrEqual(dataService.fetchOrdersCount, 2)
    }
    
    func test_filteredOrder() {
        
        // Given
        let product1 = makeProduct(id: 1, title: "Copo Térmico")
        let product2 = makeProduct(id: 2, title: "Garrafa")
        let dataService = MockSwiftDataService(initialOrders: [Order(product: product1), Order(product: product2)])
        let viewModel = OrderViewModel(dataSource: dataService)
        viewModel.refresh()

        // When
        viewModel.searchText = "   térMICO "

        // Then
        XCTAssertEqual(viewModel.filteredOrder.count, 1)
        XCTAssertEqual(viewModel.filteredOrder.first?.title, "Copo Térmico")
    }

}
