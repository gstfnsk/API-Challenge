//
//  Cart.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 18/08/25.
//

import SwiftData

@Model
class Cart {
    var product: [Int : Int] // id do produto : quantidade

    init(product: [Int : Int]) {
        self.product = product
    }
}
