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
    private let networkLayer = RatesAPI()
    private let disposeBag = DisposeBag()
    private let model = MainModel()
    var onDataUpdate: (() -> Void)?
    var valuteData: ValuteData?
    
    
    // MARK: - Methods
    func fetchExchangeRates() {
        networkLayer.getExchangeRates()
            .subscribe(onNext: { [weak self] exchangeRateResponse in
                // Обработка данных
                self?.model.saveData(data: exchangeRateResponse.valute ?? ValuteData())
                self?.valuteData = self?.model.prepareData()
                self?.onDataUpdate?()
            }, onError: { error in
                // Обработка ошибки
                NSObject.log("Error: \(error)", level: "DEBUG")
            })
            .disposed(by: disposeBag)
    }
}
