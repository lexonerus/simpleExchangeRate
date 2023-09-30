//
//  ValuteModel.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import RealmSwift

class ValuteObject: Object {
    @Persisted var symbol: String?
    @Persisted var value: Double?
    @Persisted var appLaunchDate: Date?

    override static func primaryKey() -> String? {
        return "symbol"
    }
}
