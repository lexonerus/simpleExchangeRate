//
//  ServerConstants.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation

enum ServerConstants {
    static let baseURL = "https://www.cbr-xml-daily.ru"
    
    static var httpHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
}
