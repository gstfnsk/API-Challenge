//
//  FavoriteIcon.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct FavoriteIcon: View {
    var body: some View {
        
        Button {
            
        } label: {
            Image(systemName: "heart")
                .foregroundColor(.labelsPrimary)
                .font(.system(.title3, weight: .regular))
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
        }
    }
}

#Preview {
    FavoriteIcon()
}
