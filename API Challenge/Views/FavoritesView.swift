// FavoritesView.swift (consome via EnvironmentObject)
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @State private var productsVM = ProductViewModel(service: ProductService())
    @State private var selectedProduct: Product?

    private var favoriteProducts: [Product] {
        productsVM.products.filter { favoritesVM.isFavorite(id: $0.id) }
    }

    var body: some View {
        Group {
            if favoriteProducts.isEmpty {
                EmptyState(title: "No favorites yet!", description: "Favorite an item and it will show up here.", image: .emptyFavorites)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(favoriteProducts) { product in
                            Button { selectedProduct = product } label: {
                                ProductList(product: product) // comportamento 3 (sem amount/orderDate)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
            }
        }
        .navigationTitle("Favorites")
        .task { await productsVM.loadProducts() }
        .sheet(item: $selectedProduct) { product in
            NavigationStack {
                DetailsView(product: product)
                    .navigationTitle("Details")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .presentationDragIndicator(.visible)
        }
    }
}
