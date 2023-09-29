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
    var onDataUpdate: (([String: Valute]?) -> Void)?
    
    // MARK: - Methods
    func fetchExchangeRates() {
        networkLayer.getExchangeRates()
            .subscribe(onNext: { [weak self] exchangeRateResponse in
                // Обработка данных
                let valuteData = exchangeRateResponse.valute
                self?.onDataUpdate?(valuteData)
            }, onError: { error in
                // Обработка ошибки
                NSObject.log("Error: \(error)", level: "DEBUG")
            })
            .disposed(by: disposeBag)
    }
}
