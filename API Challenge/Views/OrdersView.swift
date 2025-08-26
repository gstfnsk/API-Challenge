//
//  OrdersView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var ordersVM: OrderViewModel
    var productsVM = ProductViewModel(service: ProductService())

    var body: some View {
        NavigationStack {
            Group {
                if ordersVM.orders.isEmpty {
                    EmptyState(
                        title: "Sem pedidos ainda",
                        description: "Faça seu primeiro pedido para vê-lo aqui.",
                        image: .emptyCart
                    )
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(ordersVM.filteredOrder) { order in
                                if let product = productsVM.products.first(where: { $0.id == order.productId }) {
                                    ProductList(
                                        product: product,
                                        orderPage: true,
                                        orderHeaderText: order.orderDate.deliveryByText()
                                    )
                                } else {
                                    ProductList(
                                        product: Product(id: order.productId, title: order.title, description: "", category: "", price: order.price, thumbnail: order.thumbnail),
                                        orderPage: true,
                                        orderHeaderText: order.orderDate.deliveryByText()
                                    )
                                }
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal)
                    }
                    .contentMargins(.horizontal, 0, for: .scrollContent)
                }
            }
            .navigationTitle("Orders")
            .searchable(text: $ordersVM.searchText)
        }
        .task { await productsVM.loadProducts() }
    }
}
