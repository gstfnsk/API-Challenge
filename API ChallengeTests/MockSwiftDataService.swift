//
//  MockSwiftDataService.swift
//  API_ChallengeTests
//
//  Created by Enzo Tonatto on 21/08/25.
//

@testable import API_Challenge

final class MockSwiftDataService: SwiftDataServiceProtocol {
    var favoritesStore: [Favorites]
    var cartStore: [CartItem]

    var fetchFavoritesCount = 0
    var fetchCartCount = 0
    var addFavoriteCalls: [Int] = []
    var deleteFavoriteCalls: [Int] = []
    var addProductCalls: [CartItem] = []
    var deleteFromCartCalls: [CartItem] = []
    var updateAmountCalls: [(id: Int, newAmount: Int)] = []

    init(initialFavorites: [Favorites] = [], initialCart: [CartItem] = []) {
        self.favoritesStore = initialFavorites
        self.cartStore = initialCart
    }

    func fetchFavorites() -> [Favorites] {
        fetchFavoritesCount += 1
        return favoritesStore
    }

    func addFavorites(_ favorite: Favorites) {
        addFavoriteCalls.append(favorite.id)
        if !favoritesStore.contains(where: { $0.id == favorite.id }) {
            favoritesStore.append(favorite)
        }
    }

    func deleteFavorites(_ favorite: Favorites) {
        deleteFavoriteCalls.append(favorite.id)
        favoritesStore.removeAll { $0.id == favorite.id }
    }

    func fetchCart() -> [CartItem] {
        fetchCartCount += 1
        return cartStore
    }

    func addProduct(cart: CartItem) {
        addProductCalls.append(cart)
        if let idx = cartStore.firstIndex(where: { $0.id == cart.id }) {
            cartStore[idx].amount += cart.amount
        } else {
            cartStore.append(cart)
        }
    }

    func deleteFromCart(_ cart: CartItem) {
        deleteFromCartCalls.append(cart)
        cartStore.removeAll { $0.id == cart.id }
    }

    func updateProductAmountInCart(product: CartItem, newAmount: Int) {
    }
    
    func fetchOrders() -> [API_Challenge.Order] {
        return []
    }
    
    func addOrder(_ order: API_Challenge.Order) {
        
    }
    
    func deleteOrder(_ order: API_Challenge.Order) {
        
    }
}
