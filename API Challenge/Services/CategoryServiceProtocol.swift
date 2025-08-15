//
//  CategoryServiceProtocol.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

protocol CategoryServiceProtocol {
    func fetchCategories() async throws -> [ProductCategory]
}

