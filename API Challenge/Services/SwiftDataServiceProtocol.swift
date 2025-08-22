//
//  SwiftDataServiceProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 21/08/25.
//

import Foundation

protocol SwiftDataServiceProtocol: AnyObject {
    func fetchFavorites() -> [Favorites]
    func addFavorites(_ favorite: Favorites)
    func deleteFavorites(_ favorite: Favorites)

    func fetchCart() -> [CartItem]
    func addProduct(cart: CartItem)
    func deleteFromCart(_ cart: CartItem)
    func updateProductAmountInCart(product: CartItem, newAmount: Int)
    
    func fetchOrders() -> [Order]
    func addOrder(_ order: Order)
    func deleteOrder(_ order: Order)
}
