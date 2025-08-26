import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var ordersVM: OrderViewModel

    var body: some View {
        NavigationStack {
            Group {
                if ordersVM.orders.isEmpty {
                    EmptyState(
                        title: "No orders yet!",
                        description: "Buy an item and it will show up here.",
                        image: .emptyCart
                    )
                    .padding()
                } else if ordersVM.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(ordersVM.filteredOrder) { order in
                                if let product = ordersVM.productList.first(where: { $0.id == order.productId }) {

                                    ProductList(
                                        product: product,
                                        orderPage: true,
                                        orderHeaderText: order.orderDate.deliveryByText()
                                    )
                                } else {
                                    ProductList(
                                        product: Product(
                                            id: order.productId,
                                            title: order.title,
                                            description: "",
                                            category: "",
                                            price: order.price,
                                            thumbnail: order.thumbnail
                                        ),
                                        orderPage: true,
                                        orderHeaderText: order.orderDate.deliveryByText()
                                    )
                                }
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal)
                        // .contentMargins(.horizontal, 0, for: .scrollContent) // opcional, só iOS 17+
                    }
                }
            }
            .navigationTitle("Orders")
            .searchable(text: $ordersVM.searchText)
        }
        .task {
            await ordersVM.loadProducts()
        }
    }
}
