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
    private let dataSource: SwiftDataServiceProtocol

    init(dataSource: SwiftDataServiceProtocol) {
        self.dataSource = dataSource
        self.orders = dataSource.fetchOrders()
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
}


