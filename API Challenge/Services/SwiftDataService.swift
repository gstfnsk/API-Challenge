//
//  SwiftDataService.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData

class SwiftDataService: SwiftDataServiceProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: CartItem.self, Favorites.self, Order.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchFavorites() -> [Favorites] {
        do {
            return try modelContext.fetch(FetchDescriptor<Favorites>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchCart() -> [CartItem] {
        do {
            return try modelContext.fetch(FetchDescriptor<CartItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addFavorites(_ favorite: Favorites) {
        modelContext.insert(favorite)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addProduct(cart: CartItem) {
        modelContext.insert(cart)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteFavorites(_ favorite: Favorites) {
        modelContext.delete(favorite)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteFromCart(_ cart: CartItem) {
        modelContext.delete(cart)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateProductAmountInCart(product: CartItem, newAmount: Int) {
           product.amount = newAmount
           try? modelContext.save()
       }
    
}
