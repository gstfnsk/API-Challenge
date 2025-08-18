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
    var isFavorite: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case category
        case price
        case thumbnail
    }
}
