//
//  CategoryViewModelProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

protocol CategoryViewModelProtocol {
    var categories: [ProductCategory] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadCategories() async
}
