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
    
    var productsVM = ProductViewModel(service: ProductService())
    var selectedProduct: Product?
    private let dataSource: SwiftDataService
    
    var total = 0.0
    
    init(dataSource: SwiftDataService) {
        self.dataSource = dataSource
        cart = dataSource.fetchCart()
    }
    
    var cartProducts: [Product] {
        productsVM.products.filter { isInCart(id: $0.id) }
    }
    
    func subtractFromCart(productId: Int) {
        if let existingCart = cart.first(where: { $0.productId == productId }) {
            let newAmount = existingCart.amount - 1
            
            if newAmount > 0 {
                // update amount
                dataSource.updateProductAmountInCart(product: existingCart, newAmount: newAmount)
                existingCart.amount = newAmount
            } else {
                // remove completely
                removeFromCart(productId: productId)
            }
        }
    }
    
    func removeFromCart(productId: Int) {
        if let index = cart.firstIndex(where: { $0.productId == productId }) {
            let cartItem = cart[index]
            
            // remove from local array
            cart.remove(at: index)
            
            // remove from persistence
            dataSource.deleteFromCart(cartItem)
        }
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
    
    func amountInCart(productId: Int) -> Int {
        cart.first(where: { $0.productId == productId })?.amount ?? 0
    }
    
//    func calculateTotal() -> Double {
//        var total = 0.0
//        cart.forEach { product in
//            total = total //+ product.
//        }
//    }
}
