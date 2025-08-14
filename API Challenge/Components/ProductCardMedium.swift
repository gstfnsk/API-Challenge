//
//  ProductCard.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardMedium: View {
    
    @State var isFavorite = false
    
    var body: some View {
        
        ZStack (alignment: .topTrailing) {
            VStack (spacing: 16) {
                ZStack (alignment: .topTrailing) {
                    Image("ProductPlaceholder")
                        .frame(width: 160, height: 160)
                        
                    FavoriteIcon(isFavorite: $isFavorite)
                }
                
                VStack (alignment: .leading, spacing: 4) {
                    Text("Product name with two or more lines goes here")
                        .font(.system(.subheadline, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("US$ 00,00")
                        .font(.system(.headline, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.bottom, 4)
                
            }
            .padding(8)
            .frame(width: 178)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.backgroundsSecondary)
            )
            
            
        }
        
    }
}

#Preview {
    ProductCardMedium()
}
