//
//  Constraints.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit
import DeviceKit

enum Constraints {
    
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
        static let buttonCornerRadius = Constraints.selectValueByScreen(small: 6.0, normal: 8.0, large: 10.0)
        static let buttonLeading = Constraints.selectValueByScreen(small: 10.0, normal: 15.0, large: 20.0)
        static let buttonTrailing = Constraints.selectValueByScreen(small: 10.0, normal: 15.0, large: 20.0)
        static let buttonHeight = Constraints.selectValueByScreen(small: 30.0, normal: 40.0, large: 45.0)
        
        static let tableViewBottom = Constraints.selectValueByScreen(small: 20.0, normal: 25.0, large: 30.0)
    }
    
    enum ValuteCell {
        static let identifier = "ValuteCell"
        
        static let cellHeight = Constraints.selectValueByScreen(small: 65.0, normal: 65.0, large: 65.0)
        static let cellLabelFont = Constraints.selectValueByScreen(small: 16.0, normal: 16.0, large: 16.0)
        static let cellTitleFont = Constraints.selectValueByScreen(small: 12.0, normal: 12.0, large: 12.0)
        static let cellLabelOffset = Constraints.selectValueByScreen(small: 6.0, normal: 6.0, large: 6.0)
        static let cellTitleBottom = Constraints.selectValueByScreen(small: -2.0, normal: -2.0, large: -2.0)
        
    }
}


