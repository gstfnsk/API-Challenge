//
//  ProductList.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 14/08/25.
//

import SwiftUI

struct ProductList: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    var product: Product
    var cartPage: Bool = false
    var orderPage: Bool = false
    var orderHeaderText: String? = nil  

    var body: some View {
        let amount = cartViewModel.amountInCart(productId: product.id)

        HStack(spacing: 16) {
            AsyncImage(url: URL(string: product.thumbnail)) { img in
                img.resizable()
            } placeholder: {
                Image("ProductPlaceholder")
                    .resizable()
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.opacity(0.3)))
            }
            .frame(width: 78, height: 78)
            .padding(.vertical, 8)
            .padding(.leading, 8)

            if cartPage {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .font(.system(.footnote, weight: .regular))
                            .foregroundColor(Color(.labelsPrimary))
                            .frame(maxWidth: 157, alignment: .leading)
                        Text("US$ " + String(product.price))
                            .font(.system(.headline, weight: .semibold))
                            .foregroundColor(Color(.labelsPrimary))
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        AmountButton(symbolName: "minus", action: { cartViewModel.subtractFromCart(productId: product.id) })
                        Text(String(amount))
                        AmountButton(symbolName: "plus", action: { cartViewModel.addToCart(productId: product.id, amount: amount) })
                    }
                }
                .padding(.vertical, 16)
                .padding(.trailing, 16)

            } else if orderPage {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        if let orderHeaderText {
                            Text(orderHeaderText)
                                .font(.system(.caption, weight: .regular))
                                .foregroundColor(.labelsSecondary)
                        }
                        Text(product.title)
                            .font(.system(.footnote, weight: .regular))
                            .foregroundColor(Color(.labelsPrimary))
                            .frame(maxWidth: 157, alignment: .leading)
                        Text("US$ " + String(product.price))
                            .font(.system(.headline, weight: .semibold))
                    }
                    Spacer()
                }
                .padding(.vertical, 16)
                .padding(.trailing, 16)

            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .font(.system(.footnote, weight: .regular))
                            .foregroundColor(Color(.labelsPrimary))
                            .frame(maxWidth: 157, alignment: .leading)
                        Text("US$ " + String(product.price))
                            .font(.system(.headline, weight: .semibold))
                            .foregroundColor(Color(.labelsPrimary))
                    }
                    Spacer()
                    Button { } label: {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .scaledToFit()
                            .font(.system(.caption, weight: .regular))
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color(.labelsPrimary))
                            .frame(width: 38, height: 38)
                            .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.fillsTertiary))
                    }
                    .frame(maxWidth: 70)
                }
                .padding(.vertical, 16)
                .padding(.trailing, 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) 
        .background(RoundedRectangle(cornerRadius: 16).foregroundStyle(.backgroundsSecondary))
    }
}
