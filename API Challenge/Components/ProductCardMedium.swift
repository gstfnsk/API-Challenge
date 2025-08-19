//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardMedium: View {
    
    @Binding var product: Product
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 16) {
                ZStack (alignment: .topTrailing) {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                    } placeholder: {
                        Image("ProductPlaceholder")
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.gray.opacity(0.3))
                            )
                    }
                    .frame(width: 160, height: 160)
                    
                    FavoriteIcon(isFavorite: $product.isFavorite)

                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.system(.subheadline, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("US$ " + String(product.price))
                        .font(.system(.headline, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 4)
                
            }
            .padding(8)
            .frame(width: 178, height: 250)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.backgroundsSecondary)
            )
        }
    }
}

#Preview {
    //    ProductCardMedium()
}
