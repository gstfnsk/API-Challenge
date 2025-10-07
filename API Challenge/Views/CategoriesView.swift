//
//  CategoriesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CategoriesView: View {
    @State var viewModel: CategoryViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    ForEach(viewModel.featured) { category in
                        NavigationLink(value: category) {
                            CategoryIcon(name: category.displayName, image: category.imageName)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)

                List {
                    switch viewModel.uiState {
                    case .loading:
                        HStack { Spacer(); ProgressView(); Spacer() }
                    case .error(let msg):
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Couldn't load categories").font(.headline)
                            Text(msg).font(.footnote).foregroundStyle(.secondary)
                            Button("Try Again") { Task { await viewModel.loadCategories() } }
                                .buttonStyle(.borderedProminent)
                        }
                        .listRowSeparator(.hidden)
                    case .loaded:
                        ForEach(viewModel.filteredCategories) { category in
                            NavigationLink(value: category) {
                                CategoryRow(name: category.displayName)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText) 
                .task { await viewModel.loadCategories() }
                .refreshable { await viewModel.loadCategories() }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: ProductCategory.self) { category in
                ProductsByCategoryView(category: category)
            }
        }
    }
}

#Preview {
    TabBar()
}
