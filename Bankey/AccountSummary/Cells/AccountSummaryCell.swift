//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Ary Boby Siregar on 09/09/22.
//

import Foundation
import UIKit

class AccountSummaryCell:UITableViewCell{
    
    enum AccountType:String{
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel{
        let accountType:AccountType
        let accountName:String
        let balance:Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel:ViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLable = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight:CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
}

extension AccountSummaryCell{
    private func setup(){
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account Type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.font = UIFont.preferredFont(forTextStyle: .body)
        nameLable.adjustsFontForContentSizeCategory = true
        nameLable.text = "No-Fee-All-In Chequing"
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.text = "Some Balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "xxxx", cents: "xx")
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")?.withTintColor(appColor,renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLable)
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(chevronImageView)
        
        contentView.addSubview(balanceStackView)
    }
    
    private func layout(){
        //typeLabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
        //underlineView
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])
        //nameLable
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLable.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        //balance stack view
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLable.trailingAnchor,constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
        ])
        //chevronImage
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 1),
            chevronImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 1),
        ])
        
    }
    
    private func makeFormattedBalance(dollars:String, cents:String)->NSMutableAttributedString{
        let dollarSignAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .callout),.baselineOffset:8]
        let dollarAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes:[NSAttributedString.Key:Any] = [.font:UIFont.preferredFont(forTextStyle: .callout),.baselineOffset:8]
        
        let rootString = NSMutableAttributedString(string: "$",attributes: dollarSignAttributes)
        let dollarString = NSMutableAttributedString(string: dollars,attributes: dollarAttributes)
        let centString = NSMutableAttributedString(string: cents,attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryCell{
    func configure(with vm:ViewModel){
        typeLabel.text = vm.accountType.rawValue
        nameLable.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        
        switch vm.accountType{
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
            break
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
            break
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
            break
        }
        
    }
}
