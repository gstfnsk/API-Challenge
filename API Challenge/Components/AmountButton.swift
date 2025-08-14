//
//  AmountButton.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 14/08/25.
//

import SwiftUI

struct AmountButton: View {
    
    var symbolName: String
    var action: ()
    
    var body: some View {
        Button {
            action
        } label: {
            Image(systemName: symbolName)
                .padding(.vertical, 4)
                .padding(.horizontal, 4)
                .font(.system(.caption, weight: .regular))
                .frame(width: 23, height: 23)
                .foregroundColor(Color(.labelsPrimary))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.fillsTertiary)
                )
                
        }
    }
}

    #Preview {
        AmountButton(symbolName: "plus", action: ())
    }
