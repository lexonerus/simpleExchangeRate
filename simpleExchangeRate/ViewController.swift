//
//  ViewController.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let networkLayer = RatesAPI()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
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

