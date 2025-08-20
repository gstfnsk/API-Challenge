//
//  API_ChallengeApp.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

// API_ChallengeApp.swift
import SwiftUI

@main
struct API_ChallengeApp: App {
    @StateObject private var favoritesVM = FavoritesViewModel(dataSource: SwiftDataService())

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(favoritesVM)
        }
    }
}

