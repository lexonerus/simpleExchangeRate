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
    var onDataUpdate: (() -> Void)?
    var valuteData: [String: Valute]?
    
    // MARK: - Methods
    func fetchExchangeRates() {
        networkLayer.getExchangeRates()
            .subscribe(onNext: { [weak self] exchangeRateResponse in
                // Обработка данных
                self?.valuteData = exchangeRateResponse.valute
                self?.onDataUpdate?()
            }, onError: { error in
                // Обработка ошибки
                NSObject.log("Error: \(error)", level: "DEBUG")
            })
            .disposed(by: disposeBag)
    }
}
