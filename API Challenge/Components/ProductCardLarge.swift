//
//  ProductCardLarge.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    @Binding var product: Product
    
    init(product: Binding<Product>, favoritesViewModel: FavoritesViewModel) {
        self._product = product
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Image("ProductPlaceholder")
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.graysGray5)
                        )
                }
                .frame(width: 160, height: 160)
                .accessibilityLabel(Text("Product image \(product.title)"))

                
                VStack(alignment: .leading, spacing: 32) {
                    Text(ProductCategory(rawValue: product.category)?.displayName.uppercased() ?? product.category.uppercased())
                        .font(.system(.footnote, weight: .regular))
                        .foregroundColor(.labelsSecondary)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .font(.system(.subheadline, weight: .regular)).lineLimit(2)
                            .truncationMode(.tail)
                            .foregroundStyle(.labelsPrimary)
                            .accessibilityLabel("Product name: \(product.title)")
                        
                        Text(String(localized: "price_prefix") + " " + String(product.price))
                            .accessibilityLabel(Text("Price"))
                            .accessibilityValue(Text(String(localized: "price_prefix") + " \(product.price)"))
                            .font(.system(.headline, weight: .semibold))
                            .foregroundStyle(.labelsPrimary)
                    }
                }
                .padding(.bottom, 24)
                Spacer()
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.backgroundsSecondary)
            )
            
            FavoriteIcon(
                isFavorite: Binding(
                    get: { favoritesViewModel.isFavorite(id: product.id) },
                    set: { _ in favoritesViewModel.toggleFavorite(id: product.id) }
                )
            )
            .accessibilityLabel("Favorite product")
            .accessibilityValue(favoritesViewModel.isFavorite(id: product.id) ? "Marked favorite" : "Not marked favorite")
            .accessibilityHint("Tap to favorite the product")


            .padding(8)
        }
    }
}

//#Preview {
//    @State static var mock = Product.mock
//    ProductCardLarge(product: $mock, favoritesViewModel: FavoritesViewModel(dataSource: .shared))
//}
