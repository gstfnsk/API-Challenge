//
//  Product.swift
//  API Challenge
//
//  Created by Giulia Stefainski on 13/08/25.
//

struct ProductResponse: Decodable {
    var products: [Product]
}

struct Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var thumbnail: String
}

