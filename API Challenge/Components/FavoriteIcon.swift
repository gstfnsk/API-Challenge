//
//  FavoriteIcon.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct FavoriteIcon: View {
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.labelsPrimary)
                .font(.system(.title3, weight: .regular))
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FavoriteIcon(isFavorite: .constant(false))
}
