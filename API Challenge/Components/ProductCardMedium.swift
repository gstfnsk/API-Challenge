//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardMedium: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel

    @Binding var product: Product
    
    init(product: Binding<Product>, favoritesViewModel: FavoritesViewModel) {
        self._product = product
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack{
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                        .scaledToFit()
                        .frame(width: 161, height: 160)
                    } placeholder: {
                        Image("ProductPlaceholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 161, height: 160)
                            .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.graysGray5))
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.system(.subheadline, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Text("US$ " + String(product.price))
                        .font(.system(.headline, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(8)
            .frame(width: 178, height: 250)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.backgroundsSecondary)
            )
            FavoriteIcon(
                isFavorite: Binding(
                    get: { favoritesViewModel.isFavorite(id: product.id) },
                    set: { _ in favoritesViewModel.toggleFavorite(id: product.id) }
                )
            )
            .padding(8)
        }
    }
}


#Preview {
    //    ProductCardMedium()
}
