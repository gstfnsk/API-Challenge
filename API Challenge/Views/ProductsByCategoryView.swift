//
//  ProductsByCategoryView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 15/08/25.
//

import SwiftUI

struct ProductsByCategoryView: View {
    @Bindable var viewModel = ProductsByCategoryViewModel()
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    @State private var selectedProduct: Product?

    let category: ProductCategory
    let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView().padding()
            } else if let err = viewModel.errorMessage {
                VStack(spacing: 8) {
                    Text("Couldn't load products").font(.headline)
                    Text(err).font(.footnote).foregroundStyle(.secondary)
                    Button("Try Again") { Task { await viewModel.load(category: category) } }
                        .buttonStyle(.borderedProminent)
                }
                .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredProducts) { product in
                        if let i = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                            Button {
                                selectedProduct = viewModel.products[i]
                            } label: {
                                ProductCardMedium(
                                    product: $viewModel.products[i],
                                    favoritesViewModel: favoritesVM
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )        .navigationTitle(category.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.load(category: category) }
        .refreshable { await viewModel.load(category: category) }
        .toolbarBackground(.visible, for: .navigationBar)
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

#Preview {
    TabBar()
}
