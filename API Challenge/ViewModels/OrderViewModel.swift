//
//  OrderViewModel.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 22/08/25.
//
import Foundation
import Combine
import SwiftData

final class OrderViewModel: ObservableObject, OrderViewModelProtocol {
    @Published var orders: [Order] = []
    var productList: [Product] = []
    private let dataSource: SwiftDataServiceProtocol
    private let productService: ProductServiceProtocol
    var isLoading: Bool = false
    var errorMessage: String = ""

    @Published var searchText: String = "" {
        didSet { updateDerivedState() }
    }
    var uiState: CategoryUIState = .loading

    init(dataSource: SwiftDataServiceProtocol, productService: ProductServiceProtocol) {
        self.dataSource = dataSource
        self.orders = dataSource.fetchOrders()
        self.productService = productService
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            productList = try await productService.fetchProducts()
        } catch {
            errorMessage = "Error to fetch Products: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func placeOrder(from product: Product, at date: Date = .init()) {
        let order = Order(product: product, date: date)
        dataSource.addOrder(order)
        orders = dataSource.fetchOrders()
    }

    func deleteOrder(_ order: Order) {
        dataSource.deleteOrder(order)
        orders = dataSource.fetchOrders()
    }

    func refresh() {
        orders = dataSource.fetchOrders()
    }
    
    var filteredOrder: [Order] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return orders }
        return orders.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }
    
    private func updateDerivedState() {
        uiState = orders.isEmpty ? .loaded(isEmpty: true) : .loaded(isEmpty: orders.isEmpty)
    }

   
}


