//
//  ButtonComponent.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 15/08/25.
//
//
import SwiftUI

struct ButtonComponent: View {
    
    var title: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(.body, weight: .semibold))
                .foregroundColor(Color(.labelsPrimary))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.fillsTertiary))

        }.padding(.horizontal, 16)
    }
}

        #Preview {
//            ButtonComponent(title:"Add to cart", action:())
        }
