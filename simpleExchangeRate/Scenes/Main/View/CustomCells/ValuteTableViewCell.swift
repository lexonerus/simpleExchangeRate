//
//  ValuteTableViewCell.swift
//  simpleExchangeRate
//
//  Created by Alexey Krzywicki on 29.09.2023.
//

import UIKit
import SnapKit


// MARK: - ValuteTableViewCell
class ValuteTableViewCell: UITableViewCell {

    // MARK: - UI Elements
    private let keyTitle = UILabel()
    private let keyLabel = UILabel()
    private let valueTitle = UILabel()
    private let valueLabel = UILabel()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateUI(keyText: String, valueText: String) {
        self.keyLabel.text = keyText
        self.valueLabel.text = valueText
    }
}

// MARK: - Layout
private extension ValuteTableViewCell {
    func setupLayout() {
        configureKeyLabel()
        configureKeyTitle()
        configureValueLabel()
        configureValueTitle()
    }
    func configureKeyLabel() {
        keyLabel.textAlignment = .left
        keyLabel.font = UIFont.boldSystemFont(ofSize: Constraints.ValuteCell.cellLabelFont)
        contentView.addSubview(keyLabel)
        
        keyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView).offset(Constraints.ValuteCell.cellLabelOffset)
            make.leading.equalTo(contentView.snp.leadingMargin)
        }
    }
    func configureKeyTitle() {
        contentView.addSubview(keyTitle)
        keyTitle.font = UIFont.systemFont(ofSize: Constraints.ValuteCell.cellTitleFont, weight: .light)
        keyTitle.textColor = .gray
        keyTitle.text = "ValuteCell.KeyTitle".localized
        
        keyTitle.snp.makeConstraints { make in
            make.bottom.equalTo(keyLabel.snp.top).offset(Constraints.ValuteCell.cellTitleBottom)
            make.leading.equalTo(keyLabel)
        }
    }
    func configureValueLabel() {
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.systemFont(ofSize: Constraints.ValuteCell.cellLabelFont)
        contentView.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView).offset(Constraints.ValuteCell.cellLabelOffset)
            make.trailing.equalTo(contentView.snp.trailingMargin)
        }
    }
    func configureValueTitle() {
        contentView.addSubview(valueTitle)
        valueTitle.font = UIFont.systemFont(ofSize: Constraints.ValuteCell.cellTitleFont, weight: .light)
        valueTitle.textColor = .gray
        valueTitle.text = "ValuteCell.KeyValue".localized
        
        valueTitle.snp.makeConstraints { make in
            make.bottom.equalTo(valueLabel.snp.top).offset(Constraints.ValuteCell.cellTitleBottom)
            make.trailing.equalTo(valueLabel)
        }
    }

}
