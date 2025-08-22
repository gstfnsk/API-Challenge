//
//  Order.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 18/08/25.
//

import SwiftData
import Foundation

@Model
class Order {
    var productId: Int
    var title: String
    var price: Double
    var thumbnail: String
    var orderDate: Date
    
    init(productId: Int, title: String, price: Double, thumbnail: String, orderDate: Date) {
        self.productId = productId
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
        self.orderDate = orderDate
    }

    convenience init(product: Product, date: Date = .init()) {
            self.init(productId: product.id,
                      title: product.title,
                      price: product.price,
                      thumbnail: product.thumbnail,
                      orderDate: date)
    }
    
}
