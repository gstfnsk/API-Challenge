//
//  Order.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 18/08/25.
//

import SwiftData

@Model
class Order {
    var product: [Int : String] // id do produto : data

    init(product: [Int : String]) {
        self.product = product
    }
}
