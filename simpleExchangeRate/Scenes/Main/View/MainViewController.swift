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
    private let tableView = UITableView()
    private let loader = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    
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
        configureLoaderView()
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
        tableView.backgroundColor = #colorLiteral(red: 0.972730027, green: 0.9611258826, blue: 0.9524819678, alpha: 1)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(tableViewPulled), for: .valueChanged)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-Constraints.MainScene.tableViewBottom)
        }
    }
    func moveButtonToBottom() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.tableView.alpha = 1.0
            self?.button.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(Constraints.MainScene.buttonBottomInset)
                make.centerX.equalToSuperview()
                make.leading.equalToSuperview().offset(Constraints.MainScene.buttonLeading)
                make.trailing.equalToSuperview().inset(Constraints.MainScene.buttonTrailing)
                make.height.equalTo(Constraints.MainScene.buttonHeight)
            }
            self?.view.layoutIfNeeded()
        }

    }
    func configureLoaderView() {
        view.addSubview(loader)
        loader.style = .large
        loader.stopAnimating()
        
        loader.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tableView.snp.centerY)
        }
    }
}

// MARK: - Bindings
private extension MainViewController {
    func bindViewModel() {
        bindData()
        bindError()
    }
    func bindData() {
        viewModel?.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.moveButtonToBottom()
                self?.tableView.reloadData()
                self?.loader.stopAnimating()
                if let isRefreshing = self?.refreshControl.isRefreshing, isRefreshing {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    func bindError() {
        viewModel?.onErrorUpdate = { [weak self] error in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                self?.showErrorAlert(error: error)
            }
        }
    }
}

// MARK: - Actions
private extension MainViewController {
    @objc func buttonPressed() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1.0)
        viewModel?.fetchExchangeRates()
        loader.startAnimating()
    }
    @objc func tableViewPulled() {
        viewModel?.fetchExchangeRates()
    }
    func showErrorAlert(error: String) {
        let alertController = UIAlertController(title: "MainScene.ErrorAlert.Title".localized,
                                                message: String(format: "MainScene.ErrorAlert.Message".localized, error),
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "MainScene.ErrorAlert.ButtonTitle".localized, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TableView delegates
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.valuteData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constraints.ValuteCell.identifier, for: indexPath) as! ValuteTableViewCell

        if let valuteData = viewModel?.valuteData {
            let item = valuteData[indexPath.row]
            let symbol = item.symbol ?? "N/A"
            let value = item.value
            
            cell.updateUI(keyText: symbol, valueText: ((value?.rounded(toDecimalPlaces: 2) ?? "00.00") + " RUB") )
        }
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.9278221369, blue: 0.9269082432, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.972730027, green: 0.9611258826, blue: 0.9524819678, alpha: 1)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constraints.ValuteCell.cellHeight
    }
    
}
