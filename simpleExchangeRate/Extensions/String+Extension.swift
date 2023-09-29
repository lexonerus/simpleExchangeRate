//
//  String+Extension.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
