//
//  EmptyView.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import SwiftUI

struct EmptyView: View {
    
    var title: String
    var description: String
    var image: ImageResource
    
    var body: some View {
        VStack(spacing: 8) {
            Image(image)
                .frame(width: 65, height: 69, alignment: .center)
            VStack(spacing: 16) {
                Text(title).font(.system(.body, weight: .semibold ))
                Text(description).font(.system(.body, weight: .regular ))
                    .foregroundColor(Color(.labelsSecondary))
            }
        }
    }
}

#Preview {
//    EmptyView(title: "a", description: "a")
}
