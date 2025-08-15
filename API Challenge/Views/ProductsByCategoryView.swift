//
//  ProductsByCategoryView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 15/08/25.
//

import SwiftUI

struct ProductsByCategoryView: View {
    let category: ProductCategory
    
    @State private var searchText: String = ""
    var viewModel = ProductsByCategoryViewModel()
    
    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]
    
    private var filtered: [Product] {
            let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !q.isEmpty else { return viewModel.products }
            return viewModel.products.filter {
                $0.title.localizedCaseInsensitiveContains(q) ||
                $0.description.localizedCaseInsensitiveContains(q)
            }
        }
    
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
                    ForEach(filtered) { product in
                        NavigationLink {
                                DetailsView(product: product)
                            } label: {
                                ProductCardMedium(product: product)
                            }
                            .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .navigationTitle(category.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.load(category: category) }
        .refreshable { await viewModel.load(category: category) }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)

    }
}

#Preview {
    TabBar()
}
