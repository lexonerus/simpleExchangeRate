//
//  HTTPMethod.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation

/// HTTPMethod используется для установки типа HTTP-метода создаваемого запроса (GET, POST, PUT, PATCH, DELETE).
public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
