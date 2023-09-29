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
    private var valuteData: [String: Valute]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.moveButtonToBottom()
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Views
    private let button = UIButton()
    private let tableView = UITableView()
    
    // MARK: - Initializers
    init(viewModel: MainViewModel? = nil) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindViewModel()
    }
}

// MARK: - Layout
private extension MainViewController {
    func setupLayout() {
        configureView()
        configureButton()
        configureTableView()
    }
    func configureView() {
        view.backgroundColor = .red
        title = "MainScene.Title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func configureButton() {
        view.addSubview(button)
        
        button.setTitle("MainScene.Button.Title".localized, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = Constraints.MainScene.buttonCornerRadius
        
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constraints.MainScene.buttonLeading)
            make.trailing.equalToSuperview().inset(Constraints.MainScene.buttonTrailing)
            make.height.equalTo(Constraints.MainScene.buttonHeight)
        }
    }
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ValuteTableViewCell.self, forCellReuseIdentifier: Constraints.ValuteCell.identifier)
        tableView.alpha = 0
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-30)
        }
    }
    func moveButtonToBottom() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.tableView.alpha = 1.0
            self?.button.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(Constraints.MainScene.tableViewBottom)
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(Constraints.MainScene.buttonLeading)
                make.trailing.equalToSuperview().inset(Constraints.MainScene.buttonTrailing)
                make.height.equalTo(Constraints.MainScene.buttonHeight)
            }
            self?.view.layoutIfNeeded()
        }

    }
}

// MARK: - Bindings
private extension MainViewController {
    func bindViewModel() {
        viewModel?.onDataUpdate = { [weak self] valuteData in
            self?.valuteData = valuteData
        }
    }
}

// MARK: - Actions
private extension MainViewController {
    @objc func buttonPressed() {
        viewModel?.fetchExchangeRates()
    }
}

// MARK: - TableView delegates
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        valuteData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constraints.ValuteCell.identifier, for: indexPath) as! ValuteTableViewCell

        if let valuteData = valuteData {
            let keys = Array(valuteData.keys)
            let key = keys[indexPath.row]
            let valute = valuteData[key]
            
            cell.updateUI(keyText: key.description, valueText: ((valute?.value?.rounded(toDecimalPlaces: 2) ?? "00.00") + "RUB") )
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constraints.ValuteCell.cellHeight
    }
    
}
