//
//  DetailsView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 15/08/25.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var cartModel: CartViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var product: Product
    
    init(product: Binding<Product>, favoritesViewModel: FavoritesViewModel) {
        self._product = product
        self.favoritesViewModel = favoritesViewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    ZStack (alignment: .topTrailing) {
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                                .scaledToFit()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(.graysGray5))
                            
                        } placeholder: {
                            Image("ProductPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(.backgroundsSecondary)
                                )
                        }
                        .frame(width: 361, height: 361)
                        
                        FavoriteIcon(
                            isFavorite: Binding(
                                get: { favoritesViewModel.isFavorite(id: product.id) },
                                set: { _ in favoritesViewModel.toggleFavorite(id: product.id) }
                            )
                        )
                        .padding(.top, 16)
                        .padding(.trailing, 16)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title).foregroundColor(Color(.labelsPrimary))
                            .font(.system(.title3, weight: .regular )).lineLimit(2)
                            .truncationMode(.tail)
                        Text("US$ " + String(product.price)).foregroundColor(Color(.labelsPrimary))
                            .font(.system(.title2, weight: .bold ))
                    }
                    Text(product.description).foregroundColor(Color(.labelsSecondary))
                        .font(.system(.body, weight: .regular ))
                }
            }
            
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(Color.backgroundsSecondary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            ButtonComponent(title: "Add to cart") {
                cartModel.addToCart(productId: product.id, amount: 1)
                dismiss()
            }
        }
    }
}

#Preview {
    TabBar()
}
