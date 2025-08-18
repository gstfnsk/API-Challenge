//
//  FavoritesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    var products: [Product] = []
    
    var body: some View {
        
        NavigationStack {
            if products.isEmpty {
                EmptyState(
                    title: "No favorites yet!",
                    description: "Favorite an item and it will show up here.",
                    image: .emptyFavorites
                )
            } else {
                VStack {
                    ForEach(products) { product in
                        ProductList(product: product, amount: nil, orderDate: nil)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    //    FavoritesView()
}
