//
//  MainViewModel.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import Foundation
import RxSwift

// MARK: - MainViewModel
class MainViewModel {
    
    // MARK: - Properties
    let networkLayer = RatesAPI()
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    func getData() {
        networkLayer.getExchangeRates()
            .subscribe(onNext: { exchangeRateResponse in
                // Обработка данных
                NSObject.log("Exchange rates: \(String(describing: exchangeRateResponse.valute))", level: "DEBUG")
            }, onError: { error in
                // Обработка ошибки
                NSObject.log("Error: \(error)", level: "DEBUG")
            })
            .disposed(by: disposeBag)
    }
}
