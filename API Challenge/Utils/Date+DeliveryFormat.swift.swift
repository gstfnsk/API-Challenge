//
//  Untitled.swift
//  API Challenge
//
//  Created by Enzo Tonatto on 22/08/25.
//
import Foundation

extension Date {
    func deliveryByText(locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let df = DateFormatter()
        df.locale = locale
        df.dateFormat = "MMMM, dd"
        return "DELIVERY BY \(df.string(from: self).uppercased())"
    }
}
