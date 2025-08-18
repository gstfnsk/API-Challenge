//
//  FavoritesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @State var viewModel: ProductViewModel
    var isEmpty: Bool = true
    
    var body: some View {
        
        NavigationStack {
            if (isEmpty) {
                EmptyState(
                    title: "No favorites yet!",
                    description: "Favorite an item and it will show up here.",
                    image: .emptyFavorites)
            }
            else {
                VStack {
                    ForEach(viewModel.favoritedProducts()) { product in
                        ProductList(product: product, amount: nil, orderDate: nil)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView(viewModel: ProductViewModel(service: ProductService()))
}
