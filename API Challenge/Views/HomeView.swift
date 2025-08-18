//
//  HomeView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: ProductViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .foregroundColor(.labelsPrimary)
                            .font(.system(.title2, weight: .bold))
                        ProductCardLarge(product: $viewModel.products[0])
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top picks")
                                .foregroundColor(.labelsPrimary)
                                .font(.system(.title2, weight: .bold))
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach($viewModel.products) { $product in
                                    ProductCardMedium(product: $product)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .navigationTitle("Home")
            }.task {
                await viewModel.loadProducts()
            }
        }
    }
}
    
    #Preview {
        TabBar()
    }
    
