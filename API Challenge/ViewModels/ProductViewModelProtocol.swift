//
//  ProductViewModelProtocol.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

import Foundation

protocol ProductViewModelProtocol {
    var product: Product? { get }
    var products: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadProducts() async
    
}
