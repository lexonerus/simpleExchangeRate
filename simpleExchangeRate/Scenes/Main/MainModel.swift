//
//  MainModel.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import RealmSwift

typealias ValuteData = [String: Valute]

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
    
    func prepareData() -> ValuteData? {
        loadData()
        if let valuteDataObjects = valuteDataObjects {
            var data = ValuteData()
            for item in valuteDataObjects {
                data.updateValue(Valute(id: nil, numCode: nil, charCode: nil, nominal: nil, name: nil, value: item.value, previous: nil), forKey: (item.symbol ?? ""))
            }
            return data
        } else {
            return ValuteData()
        }
    }
}

