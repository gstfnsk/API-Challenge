//
//  CategoryRow.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import SwiftUI

struct CategoryRow: View {
    
    var name: String
    
    var body: some View {
        HStack (alignment: .firstTextBaseline){
            Text(name)
                .font(.system(.body, weight: .regular))
            
            Spacer()
        }
        .padding(.vertical, 19)
        
    }
}

#Preview {
    CategoryRow(name: "oi")
}
