//
//  CategoryViewModelProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

// CategoryViewModelProtocol.swift
import Foundation

@MainActor
protocol CategoryViewModelProtocol: AnyObject {
    var categories: [ProductCategory] { get }
    var searchText: String { get set }
    var filteredCategories: [ProductCategory] { get }
    var uiState: CategoryUIState { get }
    func loadCategories() async
}

enum CategoryUIState: Equatable {
    case loading
    case error(String)
    case loaded(isEmpty: Bool)
}
