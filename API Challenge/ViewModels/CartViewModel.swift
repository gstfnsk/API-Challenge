//
//  CartViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData
import Combine

class CartViewModel: ObservableObject {
    @Published var cart: [Cart] = []
    
    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        cart = dataSource.fetchCart()
    }
    
    func addToCart(id: Int) {
        let currentCart: Cart
            if let existingCart = cart.first {
                currentCart = existingCart
            } else {
                currentCart = Cart(product: [:])
                cart.append(currentCart)
            }
        
            if let currentAmount = currentCart.product[id] {
                currentCart.product[id] = currentAmount + 1
            } else {
                currentCart.product[id] = 1
            }
        dataSource.addProduct(cart: currentCart)
    }
    
    func isOnCart(id: Int) -> Bool {
        for c in cart {
                if c.product.keys.contains(id) {
                    return true
                }
            }
            return false
    }
}
