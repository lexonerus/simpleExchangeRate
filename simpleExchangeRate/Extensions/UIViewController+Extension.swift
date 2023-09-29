//
//  UIViewController+Extension.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit

class MyViewController: UIViewController {
    
    init() {
        super.init (nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable, message: "Nibs are unsupported")
    public required init?(coder aDecoder: NSCoder) { fatalError ("Nibs are unsupported" )
    }
    
}
