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
    
    func getExchangeRates() -> Observable<ExchangeRateResponse> {
        let path = "/daily_json.js"
        let method = HTTPMethod.get.rawValue
        let headers = ServerConstants.httpHeaders
        
        return Observable.create { observer in
            let url = URL(string: (self.baseURL + path))!
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.allHTTPHeaderFields = headers
            // пустое тело
            request.httpBody = Data()
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    let errorMessage = NetworkError.handleError(error)
                    observer.onError(NetworkError.serverError(message: errorMessage))
                } else if let data = data {
                    do {
                        let exchangeRateResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                        observer.onNext(exchangeRateResponse)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                } else {
                    observer.onError(NetworkError.unknownError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }

}


