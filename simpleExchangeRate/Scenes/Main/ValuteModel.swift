//
//  ValuteModel.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import RealmSwift

class ValuteObject: Object {
    @Persisted var id: String?
    @Persisted var numCode: String?
    @Persisted var charCode: String?
    @Persisted var nominal: Int?
    @Persisted var name: String?
    @Persisted var value: Double?
    @Persisted var previous: Double?
    @Persisted var launchDate: Date?

    override static func primaryKey() -> String? {
        return "id"
    }
}
