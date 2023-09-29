//
//  ExchangeRateResponse.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation

// MARK: - ExchangeRateResponse
struct ExchangeRateResponse: Codable {
    let date, previousDate: String?
    let previousURL: String?
    let timestamp: String?
    let valute: [String: Valute]?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

// MARK: - Valute
struct Valute: Codable {
    let id, numCode, charCode: String?
    let nominal: Int?
    let name: String?
    let value, previous: Double?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}
