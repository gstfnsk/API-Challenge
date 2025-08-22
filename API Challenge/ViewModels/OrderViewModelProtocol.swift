//
//  OrderViewModelProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 22/08/25.
//

import Foundation

protocol OrderViewModelProtocol {
    var orders: [Order] { get set }
    func placeOrder(from product: Product, at date: Date)
    func deleteOrder(_ order: Order)
    func refresh()
}
