//
//  ViewController.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit
import SnapKit

// MARK: - MainViewController
class MainViewController: MyViewController {
    
    // MARK: - Properties
    private let viewModel: MainViewModel?
    
    // MARK: - Views
    private let button = UIButton()
    
    // MARK: - Initializers
    init(viewModel: MainViewModel? = nil) {
        self.viewModel = viewModel
        super.init()
        setupLayout()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel?.getData()
    }
}

private extension MainViewController {
    func setupLayout() {
        configureButton()
    }
    func configureButton() {
        view.addSubview(button)
        button.setTitle("MainScene.Button.Title".localized, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = Defaults.MainScene.buttonCornerRadius
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Defaults.MainScene.buttonLeading)
            make.trailing.equalToSuperview().inset(Defaults.MainScene.buttonTrailing)
            make.height.equalTo(Defaults.MainScene.buttonHeight)
        }
    }
}

private extension MainViewController {
    @objc func buttonPressed() {
        
    }
}

