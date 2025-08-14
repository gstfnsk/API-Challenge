//
//  CartView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        
        NavigationStack {
            EmptyView(
                title: "Your cart is empty!",
                description: "Add an item to your cart.",
                image: .emptyCart)
        }
        .navigationTitle("Cart")
        
    }
}
#Preview {
    CartView()
}
