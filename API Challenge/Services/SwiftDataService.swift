//
//  SwiftDataService.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 19/08/25.
//

import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: Cart.self, Favorites.self, Order.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchFavorites() -> [Favorites] {
        do {
            return try modelContext.fetch(FetchDescriptor<Favorites>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addFavorites(_ favorites: Favorites) {
        modelContext.insert(favorites)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
