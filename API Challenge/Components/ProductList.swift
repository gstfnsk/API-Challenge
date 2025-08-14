//
//  ProductList.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 14/08/25.
//

import SwiftUI

struct ProductList: View {
    
    var title: String
    var price: Double
    var amount: Int?
    var image: ImageResource
    var order: Date?
    
    var body: some View {
        HStack(spacing: 16) {
            Image(image)
                .padding(.vertical, 8)
                .padding(.leading, 8)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.system(.footnote, weight: .regular ))
                        .frame(maxWidth: 157)
                    Text("US$ " + String(price)).font(.system(.headline, weight: .semibold ))
                }
                if let amount {
                    HStack {
                        AmountButton(symbolName: "minus", action: ())
                        Text(String(amount))
                        AmountButton(symbolName: "plus", action: ())
                    }
                    .frame(maxWidth: 70)
                }
            }.padding(.vertical, 16)
                .padding(.trailing, 16)
        }.background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
    }
}

#Preview {
    ProductList(title: "Product name with two or more lines goes here", price: 6.99, amount: 1, image: .productCart)
}
