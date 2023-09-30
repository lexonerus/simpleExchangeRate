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
    private let reachabilityService = ReachabilityService()
    private let networkLayer = RatesAPI()
    private let disposeBag = DisposeBag()
    private let model: MainModel?
    var onDataUpdate: (() -> Void)?
    var onErrorUpdate: ((String) -> Void)?
    var valuteData: [Valute]? {
        didSet {
            onDataUpdate?()
        }
    }
    
    // MARK: - Initializers
    init(model: MainModel?, onDataUpdate: (() -> Void)? = nil, onErrorUpdate: ((String) -> Void)? = nil, valuteData: [Valute]? = nil) {
        self.model = model
        self.onDataUpdate = onDataUpdate
        self.onErrorUpdate = onErrorUpdate
        self.valuteData = valuteData
    }
    
    // MARK: - Methods
    func fetchExchangeRates() {
        if reachabilityService.isInternetAvailable() {
            networkLayer.getExchangeRates()
                .subscribe(onNext: { [weak self] exchangeRateResponse in
                    // Обработка данных
                    self?.model?.saveData(data: exchangeRateResponse.valute ?? ValuteData())
                    self?.valuteData = self?.model?.prepareData()
                }, onError: { [weak self] error in
                    // Обработка ошибки
                    self?.onErrorUpdate?(NetworkError.handleError(error))
                    NSObject.log("Error: \(error)", level: "DEBUG")
                })
                .disposed(by: disposeBag)
        } else {
            // загрузка локальных данных
            let error = NetworkError.noInternetConnection
            onErrorUpdate?(NetworkError.handleError(error))
            valuteData = model?.prepareData()
            NSObject.log("Last update: \(String(describing: valuteData?.first?.value))", level: "DEBUG")
        }
    }
}
