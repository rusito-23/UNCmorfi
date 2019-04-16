//
//  LastUpdateCell.swift
//  UNCmorfi
//
//  Created by Igor Andruskiewitsch on 16/04/2019.
//  Copyright © 2019 George Alegre. All rights reserved.
//

import UIKit

class LastUpdateCell: UITableViewCell {

    // MARK: static
    static let reuseIdentifier = "LastUpdateCell"
    
    enum UpdateType {
        case menu
        case balance
    }
    
    // MARK: UI vars
    let containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 3
        
        view.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        view.layer.borderWidth = 1
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 1
        
        return view
    }()
    
    let updateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: inits
    
    private static let lastUpdateDate: LastUpdateDate = LastUpdateDateImpl()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let margin = contentView.layoutMarginsGuide
        
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        
        containerView.addSubview(updateLabel)
        updateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        updateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        updateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        updateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
    }
    
    static func populate(_ tableView: UITableView, at indexPath: IndexPath, with type: UpdateType) -> LastUpdateCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LastUpdateCell.reuseIdentifier, for: indexPath) as? LastUpdateCell else {
            fatalError("Dequeued cell is not a LastUpdateCell.")
        }
        cell.updateLabel.text = createLabelText(from: type)
        return cell
    }
    
    // MARK: methods
    
    static func createLabelText(from type: UpdateType) -> String {
        let string = "last.update.date.label".localized()
        
        var date: Date?
        switch type {
        case .menu:
            date = lastUpdateDate.menu
            break
        case .balance:
            date = lastUpdateDate.balance
            break
        }
        
        guard date != nil else {
            return "last.update.date.label.error".localized()
        }
        
        return String(format: string, date!.string(with: .simpleDateFormat))
    }
    
}