//
//  CartItem.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 18/08/25.
//

import SwiftData

@Model
class CartItem {
    var productId: Int // id do produto
    var amount: Int = 0 // quantidade

    init(productId: Int, amount: Int) {
        self.productId = productId
        self.amount = amount
    }
}
