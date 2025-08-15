//
//  Category.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 14/08/25.
//

import Foundation

enum ProductCategory: String, Codable, CaseIterable, Identifiable {
    var id: String { rawValue }

    case beauty = "beauty"
    case fragrances = "fragrances"
    case furniture = "furniture"
    case groceries = "groceries"
    case homeDecoration = "home-decoration"
    case kitchenAccessories = "kitchen-accessories"
    case laptops = "laptops"
    case mensShirts = "mens-shirts"
    case mensShoes = "mens-shoes"
    case mensWatches = "mens-watches"
    case mobileAccessories = "mobile-accessories"
    case motorcycle = "motorcycle"
    case skinCare = "skin-care"
    case smartphones = "smartphones"
    case sportsAccessories = "sports-accessories"
    case sunglasses = "sunglasses"
    case tablets = "tablets"
    case tops = "tops"
    case vehicle = "vehicle"
    case womensBags = "womens-bags"
    case womensDresses = "womens-dresses"
    case womensJewellery = "womens-jewellery"
    case womensShoes = "womens-shoes"
    case womensWatches = "womens-watches"

    var displayName: String {
        rawValue.replacingOccurrences(of: "-", with: " ").capitalized
    }

    var imageName: String {
        switch self {
        case .beauty: return "sparkles"
        case .fragrances: return "drop.fill"
        case .furniture: return "chair.lounge.fill"
        case .groceries: return "basket.fill"
        case .homeDecoration: return "lamp.table.fill"
        case .kitchenAccessories: return "fork.knife"
        case .laptops: return "laptopcomputer"
        case .mensShirts: return "tshirt.fill"
        case .mensShoes: return "shoe.fill"
        case .mensWatches: return "applewatch.watchface"
        case .mobileAccessories: return "powercord.fill"
        case .motorcycle: return "motorcycle.fill"
        case .skinCare: return "face.smiling.inverse"
        case .smartphones: return "iphone.gen3"
        case .sportsAccessories: return "tennis.racket"
        case .sunglasses: return "sunglasses.fill"
        case .tablets: return "ipad"
        case .tops: return "jacket.fill"
        case .vehicle: return "car.fill"
        case .womensBags: return "handbag.fill"
        case .womensDresses: return "figure.stand.dress"
        case .womensJewellery: return "crown.fill"
        case .womensShoes: return "shoeprints.fill"
        case .womensWatches: return "watch.analog"
        }
    }
}
