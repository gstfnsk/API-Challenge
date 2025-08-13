//
//  ContentView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel: ProductViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                List {
                    // MARK: SECTION FOR HIGHLIGHT PRODUCT
                    if let product = viewModel.product {
                        Section(header: Text("Highlight")) {
                            Text(product.title)
//                            ProductComponent(product: product)
                        }
                    }
                    
                    // MARK: SECTION FOR CHARACTERS
                    Section(header: Text("All Products")) {
                        ForEach(viewModel.products) { product in
                            Text(product.title)
                        }
                    }
                }
                .navigationTitle("Product")
                .refreshable {
                    await viewModel.loadProducts()
                }
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        
        .padding()
        .task {
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    ContentView(viewModel: ProductViewModel(service: ProductService()))
}
