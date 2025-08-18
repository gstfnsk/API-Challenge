//
//  DetailsView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 15/08/25.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                ZStack (alignment: .topTrailing) {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                            .scaledToFit()

                    } placeholder: {
                        Image("ProductPlaceholder")
                            .resizable()
                            .scaledToFill()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.gray.opacity(0.3))
                            )
                    }
                    .frame(width: 361, height: 361)
                    
                    FavoriteIcon(isFavorite: $product.isFavorite)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title).foregroundColor(Color(.labelsPrimary))
                        .font(.system(.title3, weight: .regular ))
                    Text("US$ " + String(product.price)).foregroundColor(Color(.labelsPrimary))
                        .font(.system(.title2, weight: .bold ))
                }
                Text(product.description).foregroundColor(Color(.labelsSecondary))
                    .font(.system(.body, weight: .regular ))
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        Spacer()
        ButtonComponent(title: "Add to cart", action: ())
    }
}

#Preview {
//    DetailsView(product: Product(
//        id: 1,
//        title: "Apple Watch Series 9",
//        description: "O mais novo Apple Watch com tela Always-On Retina, resistência à água e monitoramento avançado de saúde.",
//        category: "Wearables",
//        price: 3999.99,
//        thumbnail: ""
//    ))
}
