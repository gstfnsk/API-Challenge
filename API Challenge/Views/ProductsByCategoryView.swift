//
//  ProductsByCategoryView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 15/08/25.
//

// ProductsByCategoryView.swift
import SwiftUI

struct ProductsByCategoryView: View {
    @Bindable var viewModel = ProductsByCategoryViewModel()   
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
                        // tenta achar o índice correspondente na fonte de verdade
                        if let i = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                            NavigationLink {
                                DetailsView(product: viewModel.products[i])
                            } label: {
                                ProductCardMedium(product: $viewModel.products[i]) // Binding<Product>
                            }
                            .buttonStyle(.plain)
                        } else {
                            // fallback: item não está na lista principal (somente leitura)
                            NavigationLink {
                                DetailsView(product: product)
                            } label: {
                                ProductCardMedium(product: .constant(product))
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
        )
        .navigationTitle(category.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.load(category: category) }
        .refreshable { await viewModel.load(category: category) }
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    TabBar()
}
