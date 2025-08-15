//
//  CategoriesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CategoriesView: View {
    @State private var searchText: String = ""
    
    let viewModel: CategoryViewModel
    
    private let featured: [ProductCategory] = [.beauty, .laptops, .tablets, .groceries]
    
    private var filtered: [ProductCategory] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return viewModel.categories }
        return viewModel.categories.filter { $0.displayName.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    ForEach(featured) { category in
                        NavigationLink(value: category) {
                            CategoryIcon(name: category.displayName, image: category.imageName)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                
                List {
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else if let error = viewModel.errorMessage {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Couldn't load categories").font(.headline)
                            Text(error).font(.footnote).foregroundStyle(.secondary)
                            Button("Try Again") { Task { await viewModel.loadCategories() } }
                                .buttonStyle(.borderedProminent)
                        }
                        .listRowSeparator(.hidden)
                    } else {
                        ForEach(filtered) { category in
                            NavigationLink(value: category) {
                                CategoryRow(name: category.displayName)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchText)
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
