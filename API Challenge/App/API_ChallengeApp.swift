//
//  API_ChallengeApp.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

// API_ChallengeApp.swift
import SwiftUI

@main
struct API_ChallengeApp: App {
    @StateObject private var favoritesVM = FavoritesViewModel(dataSource: SwiftDataService())
    @StateObject private var cartVM = CartViewModel(dataSource: SwiftDataService())
    @StateObject private var ordersVM = OrderViewModel(dataSource: SwiftDataService(), productService: ProductService())

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(favoritesVM)
                .environmentObject(cartVM)
                .environmentObject(ordersVM)
        }
    }
}

