//
//  MainModel.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import RealmSwift

typealias ValuteData = [String: ValuteResponse]

class MainModel {
    
    var valuteDataObjects: Results<ValuteObject>?
    
    func loadData() {
        let realm = try! Realm()
        valuteDataObjects = realm.objects(ValuteObject.self)
    }

    
    func saveData(data: ValuteData) {
        let realm = try! Realm()
        
        try! realm.write {
            for (symbol, valute) in data {
                if let existingObject = realm.object(ofType: ValuteObject.self, forPrimaryKey: symbol) {
                    existingObject.value = valute.value
                    existingObject.appLaunchDate = AppLaunchService.shared.appLaunchDate ?? Date()
                } else {
                    let valuteObject = ValuteObject()
                    valuteObject.symbol = symbol
                    valuteObject.value = valute.value
                    valuteObject.appLaunchDate = AppLaunchService.shared.appLaunchDate ?? Date()
                    realm.add(valuteObject)
                }
            }
        }
    }
    
    func prepareData() -> [Valute] {
        loadData()
        if let valuteDataObjects = valuteDataObjects {
            var data = [Valute]()
            
            for item in valuteDataObjects {
                let valute = Valute(value: item.value, lastUpdate: item.appLaunchDate, symbol: item.symbol)
                data.append(valute)
            }

            data.sort { $0.symbol ?? "" < $1.symbol ?? "" }
            
            return data
        } else {
            return [Valute]()
        }
    }

}

