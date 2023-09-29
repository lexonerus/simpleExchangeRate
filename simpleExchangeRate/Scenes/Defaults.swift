//
//  Constraints.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit
import DeviceKit

enum Defaults {
    
    static func selectValueByScreen<T>(small: T, normal: T, large: T) -> T {
        switch Device.current.diagonal {
        case 0...4.7:
            return small
        case 4.8...6.1:
            return normal
        case 6.2...:
            return large
        default:
            return normal
        }
    }
    
    static func isWidescreen() -> Bool {
        Device.current.screenRatio.height / Device.current.screenRatio.width > 1.9
    }
    
    enum MainScene {
        static let buttonCornerRadius = Defaults.selectValueByScreen(small: 6.0, normal: 8.0, large: 10.0)
        static let buttonLeading = Defaults.selectValueByScreen(small: 10.0, normal: 15.0, large: 20.0)
        static let buttonTrailing = Defaults.selectValueByScreen(small: 10.0, normal: 15.0, large: 20.0)
        static let buttonHeight = Defaults.selectValueByScreen(small: 30.0, normal: 40.0, large: 45.0)
    }
}


