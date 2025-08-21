//
//  CartViewModel.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData
import Combine

class CartViewModel: ObservableObject {
    @Published var cart: [CartItem] = []
    
    private let dataSource: SwiftDataService
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        cart = dataSource.fetchCart()
    }
    
    func addToCart(productId: Int, amount: Int) {
        if let existingCart = cart.first(where: { $0.productId == productId }) {
            // produto já está no carrinho: atualiza quantidade
            dataSource.updateProductAmountInCart(product: existingCart, newAmount: existingCart.amount + 1)
        } else {
            // produto não está: insere
            let newCartItem = CartItem(productId: productId, amount: 1)
            cart.append(newCartItem)
            dataSource.addProduct(cart: newCartItem)
        }
        
        cart.forEach { print($0.productId) } // id dos produtos no carrinho
    }
    
    func isInCart(id: Int) -> Bool {
            return cart.contains { $0.productId == id }
    }
}
