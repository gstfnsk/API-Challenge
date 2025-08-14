//
//  CategoriesView.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 13/08/25.
//

import SwiftUI

struct CategoriesView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        NavigationStack {
            
        }
        .searchable(text: $searchText)
        .navigationTitle("Categories")
        
    }
}

#Preview {
    TabBar()
}
