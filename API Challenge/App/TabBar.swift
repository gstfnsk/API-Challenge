//
//  TabBar.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView(viewModel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesView(viewModel: CategoryViewModel(service: CategoryService()))
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartView()
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    FavoritesView()
                }
            }
            
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    OrdersView()
                }
            }
            
        }
    }
}
