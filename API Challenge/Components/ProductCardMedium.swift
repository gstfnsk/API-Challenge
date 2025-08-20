//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardMedium: View {
    
    var favoritesViewModel: FavoritesViewModel = FavoritesViewModel(dataSource: .shared)
    
    @Binding var product: Product
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VStack {
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
//                .padding(.horizontal, 8)
            }
            .padding(8)
            .frame(width: 178, height: 250)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.backgroundsSecondary)
            )
            
            // Ícone agora está alinhado ao card, não à imagem
            FavoriteIcon(isFavorite: $product.isFavorite) {
                favoritesViewModel.toggleFavorite(id: product.id)
            }
            .padding(8) // afasta do canto do card
        }
    }
}


#Preview {
    //    ProductCardMedium()
}
