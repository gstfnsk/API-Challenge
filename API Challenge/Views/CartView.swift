//
//  CartView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var ordersVM: OrderViewModel
    
    var body: some View {
        
        NavigationStack {
            if cartVM.cartProducts.isEmpty {
                EmptyState(
                    title: "Your cart is empty!",
                    description: "Add an item to your cart.",
                    image: .emptyCart
                )
            } else {
                VStack {
                    if cartVM.productsVM.isLoading {
                        ProgressView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(cartVM.cartProducts) { cartProduct in
                                    Button { cartVM.selectedProduct = cartProduct } label: {
                                        ProductList(product: cartProduct, cartPage: true)
                                            .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 16)
                        }
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Total:")
                                    .font(.system(.subheadline, weight: .regular))
                                    .foregroundColor(Color(.labelsPrimary))
                                Spacer()
                                Text(String(localized: "price_prefix") + " "  + String(format: "%.2f", cartVM.calculateTotal()))
                                    .font(.system(.headline, weight: .semibold))
                                    .foregroundColor(Color(.labelsPrimary))
                            }
                            .padding(.horizontal, 16)
                            
                            ButtonComponent(title: "Checkout") {
                                for product in cartVM.cartProducts {
                                    ordersVM.placeOrder(from: product)
                                }
                                cartVM.clear()
                            }
                            
                        }
                        .frame(maxWidth: cartVM.componentWidth)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
        .navigationTitle("Cart")
        .task { await cartVM.productsVM.loadProducts() }
    }
}
#Preview {
    CartView()
}
