//
//  CustomError.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 30.09.2023.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case requestTimedOut
    case serverError(message: String)
    case authenticationFailed
    case unauthorizedAccess
    case unknownError

    static func handleError(_ error: Error) -> String {
        switch error {
        case NetworkError.noInternetConnection:
            return "NetworkError.noInternetConnection".localized
        case NetworkError.requestTimedOut:
            return "NetworkError.requestTimedOut".localized
        case let NetworkError.serverError(message):
            return String(format: "NetworkError.serverError".localized, message)
        case NetworkError.authenticationFailed:
            return "NetworkError.authenticationFailed".localized
        case NetworkError.unauthorizedAccess:
            return "NetworkError.unauthorizedAccess".localized
        default:
            return String(format: "NetworkError.unknownError".localized, error.localizedDescription)
        }
    }
}

