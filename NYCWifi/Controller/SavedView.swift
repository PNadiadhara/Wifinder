//
//  SavedView.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/26/21.
//

import UIKit

class SavedView: UIView {
    var gradient: CAGradientLayer!
    
    lazy var savedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpSaveViewBackground()
        tableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSaveViewBackground() {
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(displayP3Red: 255/255, green: 140/255, blue: 132/255, alpha: 1).cgColor, UIColor(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1).cgColor, UIColor(displayP3Red: 255/255, green: 225/255, blue: 137/255, alpha: 1).cgColor]
        layer.addSublayer(gradient)
    }
    
    private func tableViewConstraints() {
        addSubview(savedTableView)
        savedTableView.translatesAutoresizingMaskIntoConstraints = false
        savedTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        savedTableView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        savedTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
