//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    
    @Binding var product: Product
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 16) {
                
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
                
                VStack(alignment: .leading, spacing: 32) {
                    
                    Text(product.category)
                        .font(.system(.footnote, weight: .regular))
                        .foregroundColor(.labelsSecondary)
                                        
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(product.title)
                            .font(.system(.subheadline, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                        
                        Text("US$ " + String(product.price))
                            .font(.system(.headline, weight: .semibold))
                            .foregroundStyle(.labelsPrimary)
                    }
                }
                .padding(.bottom, 24)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.backgroundsSecondary)
            )
            
            FavoriteIcon(isFavorite: $product.isFavorite)
                .padding(8)
        }
    }
}

#Preview {
//    ProductCardLarge()
}
