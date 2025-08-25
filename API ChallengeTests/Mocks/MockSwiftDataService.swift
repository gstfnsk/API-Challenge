//
//  MockSwiftDataService.swift
//  API_ChallengeTests
//
//  Created by Enzo Tonatto on 21/08/25.
//

@testable import API_Challenge

final class MockSwiftDataService: SwiftDataServiceProtocol {
    typealias Fav  = API_Challenge.Favorites
    typealias Cart = API_Challenge.CartItem
    typealias Ord  = API_Challenge.Order

    var favoritesStore: [Fav]
    var cartStore: [Cart]
    var ordersStore: [Ord]

    var fetchFavoritesCount = 0
    var fetchCartCount = 0
    var fetchOrdersCount = 0

    var addFavoriteCalls: [Int] = []
    var deleteFavoriteCalls: [Int] = []

    var addProductCalls: [Cart] = []
    var deleteFromCartCalls: [Cart] = []
    var updateAmountCalls: [(productId: Int, newAmount: Int)] = []

    var addOrderCalls: [Ord] = []
    var deleteOrderCalls: [Ord] = []

    init(initialFavorites: [Fav] = [],
         initialCart: [Cart] = [],
         initialOrders: [Ord] = []) {
        self.favoritesStore = initialFavorites
        self.cartStore = initialCart
        self.ordersStore = initialOrders
    }

    func fetchFavorites() -> [Fav] {
        fetchFavoritesCount += 1
        return favoritesStore
    }

    func addFavorites(_ favorite: Fav) {
        addFavoriteCalls.append(favorite.id)
        if !favoritesStore.contains(where: { $0.id == favorite.id }) {
            favoritesStore.append(favorite)
        }
    }

    func deleteFavorites(_ favorite: Fav) {
        deleteFavoriteCalls.append(favorite.id)
        favoritesStore.removeAll { $0.id == favorite.id }
    }

    // MARK: Cart
    func fetchCart() -> [Cart] {
        fetchCartCount += 1
        return cartStore
    }

    func addProduct(cart: Cart) {
        addProductCalls.append(cart)
        if let idx = cartStore.firstIndex(where: { $0.productId == cart.productId }) {
            cartStore[idx].amount += cart.amount
        } else {
            cartStore.append(cart)
        }
    }

    func deleteFromCart(_ cart: Cart) {
        deleteFromCartCalls.append(cart)
        cartStore.removeAll { $0.productId == cart.productId }
    }

    func updateProductAmountInCart(product: Cart, newAmount: Int) {
        if let idx = cartStore.firstIndex(where: { $0.productId == product.productId }) {
            cartStore[idx].amount = newAmount
        }
        updateAmountCalls.append((productId: product.productId, newAmount: newAmount))
    }

    func fetchOrders() -> [Ord] {
        fetchOrdersCount += 1
        return ordersStore
    }

    func addOrder(_ order: Ord) {
        addOrderCalls.append(order)
        ordersStore.insert(order, at: 0)
    }

    func deleteOrder(_ order: Ord) {
        deleteOrderCalls.append(order)
        ordersStore.removeAll { $0.id == order.id }
    }
}
