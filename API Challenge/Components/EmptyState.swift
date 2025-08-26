//
//  EmptyView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import SwiftUI

struct EmptyState: View {
    
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    var image: ImageResource
    
    var body: some View {
        VStack(spacing: 8) {
            Image(image)
                .frame(width: 65, height: 69, alignment: .center)
            VStack(spacing: 16) {
                Text(title).font(.system(.body, weight: .semibold )).foregroundColor(Color(.labelsPrimary))
                Text(description).font(.system(.body, weight: .regular ))
                    .foregroundColor(Color(.labelsSecondary))
            }
        }
    }
}

#Preview {
//    EmptyView(title: "a", description: "a")
}
