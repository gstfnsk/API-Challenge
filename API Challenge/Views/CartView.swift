//
//  CartView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    var productsVM = ProductViewModel(service: ProductService())
    
    var body: some View {
        
        NavigationStack {
            if cartVM.cartProducts.isEmpty {
                EmptyState(
                    title: "Your cart is empty!",
                    description: "Add an item to your cart.",
                    image: .emptyCart)
            }
            else {
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
//                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                
                VStack(spacing: 16) {
                    Spacer()
                    HStack {
                        Text("Total:").font(.system(.subheadline, weight: .regular )).foregroundColor(Color(.labelsPrimary))
                            .frame(alignment: .bottomLeading)
                        Spacer()
                        Text("US$: " + String(cartVM.total)).font(.system(.headline, weight: .semibold )).foregroundColor(Color(.labelsPrimary))
                            .frame(alignment: .bottomTrailing)
                    }.padding(.horizontal, 16)
                    ButtonComponent(title: "Checkout") {
                        //ir para orders
                    }
                    
                }
                    .padding(.bottom, 16)
            }
        }
        .navigationTitle("Cart")
        .task { await cartVM.productsVM.loadProducts() }
    }
}
#Preview {
    CartView()
}
