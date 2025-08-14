//
//  OrdersView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        
        NavigationStack {
            EmptyView(
                title: "No orders yet!",
                description: "Buy an item and it will show up here.",
                image: .emptyOrders)
        }
        .navigationTitle("Orders")
        
    }
}
