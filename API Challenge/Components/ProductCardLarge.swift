//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    
    var title: String
    var description: String
    var price: Double
    var category: String
    
    @State var isFavorite = false
    
    var body: some View {
        
        ZStack (alignment: .topTrailing) {
            HStack (spacing: 16) {
                
                Image("ProductPlaceholder")
                    .frame(width: 160, height: 160)
                
                VStack (alignment: .leading, spacing: 32) {
                    
                    Text(category)
                        .font(.system(.footnote, weight: .regular))
                        .foregroundColor(.labelsSecondary)
                                        
                    VStack (alignment: .leading, spacing: 4) {
                        
                        Text(title)
                            .font(.system(.subheadline, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                        
                        Text("US$ " + String(price))
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
            
            FavoriteIcon(isFavorite: $isFavorite)
                .padding(8)
        }
        
    }
}

#Preview {
//    ProductCardLarge()
}
