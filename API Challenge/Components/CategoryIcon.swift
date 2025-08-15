//
//  CategoryIcon.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct CategoryIcon: View {
    
    var name: String
    var image: String
    
    var body: some View {
        VStack (spacing: 8) {
            Image(systemName: image)
                .font(.system(size: 38, weight: .regular))
                .frame(width: 84, height: 84)
                .foregroundColor(.fillsSecondary)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.backgroundsSecondary)
                )
            
            Text(name)
                .font(.system(.subheadline, weight: .regular))
                .foregroundStyle(.labelsPrimary)
                .lineLimit(1)
            
        }
        
    }
}

#Preview {
    CategoryIcon(name: "categoria", image: "sparkles")
}
