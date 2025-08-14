//
//  FavoritesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        
        NavigationStack {
            EmptyState(
                title: "No favorites yet!",
                description: "Favorite an item and it will show up here.",
                image: .emptyFavorites)
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView()
}
