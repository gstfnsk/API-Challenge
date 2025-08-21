//
//  CartView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @State var productsVM = ProductViewModel(service: ProductService())
    
    @State var selectedProduct: Product?
    
    var cartProducts: [Product] {
        productsVM.products.filter { cartVM.isInCart(id: $0.id) }
    }
    
    var body: some View {
        
        NavigationStack {
            if cartProducts.isEmpty {
                EmptyState(
                    title: "Your cart is empty!",
                    description: "Add an item to your cart.",
                    image: .emptyCart)
            }
            else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(cartProducts) { cartProduct in
                            let amount = cartVM.amountInCart(productId: cartProduct.id)
                            Button { selectedProduct = cartProduct } label: {
                                ProductList(product: cartProduct, amount: amount)
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
        .navigationTitle("Cart")
        .task { await productsVM.loadProducts() }
    }
}
#Preview {
    CartView()
}
