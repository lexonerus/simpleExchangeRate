//
//  RatesAPI.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation
import RxSwift

struct RatesAPI {
    private let baseURL = ServerConstants.baseURL
    private let provider = Provider()

    func getExchangeRates() -> Observable<ExchangeRateResponse> {
        let path = "/daily_json.js"
        let method = HTTPMethod.get.rawValue
        let headers = ServerConstants.httpHeaders
        let body = Data() // пустое тело
        
        let url = URL(string: (baseURL + path))!
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return provider.performNetworkRequest(request, responseType: ExchangeRateResponse.self)
    }
}


