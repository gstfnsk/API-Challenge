//
//  DetailsView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 15/08/25.
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var product: Product
    
    @State var isFavorite = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    ZStack (alignment: .topTrailing) {
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                                .scaledToFit()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.graysGray5))
                                
                        } placeholder: {
                            Image("ProductPlaceholder")
                                .resizable()
                                .scaledToFill()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.backgroundsSecondary)
                                )
                        }
                        .frame(width: 361, height: 361)
                        
                        FavoriteIcon(isFavorite: $product.isFavorite)
                            .padding(.top, 8)
                            .padding(.trailing, 8)
                        
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title).foregroundColor(Color(.labelsPrimary))
                            .font(.system(.title3, weight: .regular )).lineLimit(2)
                            .truncationMode(.tail)
                        Text("US$ " + String(product.price)).foregroundColor(Color(.labelsPrimary))
                            .font(.system(.title2, weight: .bold ))
                    }
                    Text(product.description).foregroundColor(Color(.labelsSecondary))
                        .font(.system(.body, weight: .regular ))
                    //                Spacer()
                }
                
            }
            
            .toolbar(.hidden, for: .tabBar)
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            ButtonComponent(title: "Add to cart", action: ())
            
        }
    }
}

#Preview {
    TabBar()
}
