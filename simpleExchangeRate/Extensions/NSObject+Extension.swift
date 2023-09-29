//
//  NSObject+Extension.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import OSLog

extension NSObject {
    static func log(_ message: String, level: String = "INFO") {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
        let logMessage = "\(timestamp) [\(level)] \(message)"
        os_log("%{public}@", log: .default, logMessage)
    }
}
