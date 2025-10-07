// FavoritesView.swift (consome via EnvironmentObject)
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    
    var body: some View {
        VStack {
            if favoritesVM.productsVM.isLoading {
                ProgressView()
            } else {
                if favoritesVM.favoriteProducts.isEmpty {
                    EmptyState(title: "No favorites yet!", description: "Favorite an item and it will show up here.", image: .emptyFavorites)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(favoritesVM.filteredFavorites) { product in
                                Button { favoritesVM.selectedProduct = product } label: {
                                    ProductList(product: product) // comportamento 3 (sem amount/orderDate)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
//                    .frame(maxWidth: favoritesVM.componentWidth)
                }
            }
        }
        .navigationTitle("Favorites")
        .searchable(text: $favoritesVM.searchText)
        .task { await favoritesVM.productsVM.loadProducts() }
        .sheet(item: $favoritesVM.selectedProduct) { product in
            NavigationStack {
                if let index = favoritesVM.productsVM.products.firstIndex(where: { $0.id == product.id }) {
                    DetailsView(product: $favoritesVM.productsVM.products[index], favoritesViewModel: favoritesVM )
                        .navigationTitle("Details")
                        .navigationBarTitleDisplayMode(.inline)
                        .background(Color.backgroundsPrimary)
                }
            }
            .presentationDragIndicator(.visible)
        }
    }
}
