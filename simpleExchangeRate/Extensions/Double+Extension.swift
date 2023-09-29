//
//  Double+Extension.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation

extension Double {
    func rounded(toDecimalPlaces places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
