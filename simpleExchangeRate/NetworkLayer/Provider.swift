//
//  Provider.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 30.09.2023.
//

import Foundation
import RxSwift

struct Provider {
    func performNetworkRequest<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> Observable<T> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    let errorMessage = NetworkError.handleError(error)
                    observer.onError(NetworkError.serverError(message: errorMessage))
                } else if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                        observer.onNext(decodedResponse)
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
