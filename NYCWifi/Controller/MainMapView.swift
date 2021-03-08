//
//  MainMapView.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import UIKit
import MapKit

class MainMapView: UIView {
    var gradiant: CAGradientLayer!
    
    public lazy var search: UISearchBar = {
        let searchbar = UISearchBar()
        //searchbar.keyboardType = .numberPad
        searchbar.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        searchbar.layer.cornerRadius = 10
        searchbar.placeholder = "Search By Zipcode"
        searchbar.barTintColor = UIColor.customsearchBarColor
        return searchbar
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 10.0
        map.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.4784313725, alpha: 1)
        map.layer.borderWidth = 3
        return map
    }()

    public lazy var mainTableView: UITableView = {
        var tableview = UITableView()
        tableview = UITableView(frame: .zero, style: .plain)
        tableview.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.9764705882, blue: 0.8, alpha: 1)
        tableview.sectionIndexColor = #colorLiteral(red: 0.2196078431, green: 0.6392156863, blue: 0.6470588235, alpha: 1)
        tableview.tableFooterView = UIView()
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpMainViewBG()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpMainViewBG() {
        gradiant = CAGradientLayer()
        gradiant.frame = self.bounds
        gradiant.colors = [UIColor(displayP3Red: 56/255, green: 163/255, blue: 165/255, alpha: 1).cgColor,
                           UIColor(displayP3Red: 87/255, green: 204/255, blue: 153/255, alpha: 1).cgColor,
                           UIColor(displayP3Red: 128/255, green: 237/255, blue: 153/255, alpha: 1).cgColor]
        layer.addSublayer(gradiant)
    }
    
    private func setUpConstraints() {
        addSubview(search)
        addSubview(mapView)
        addSubview(mainTableView)
        search.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), search.leadingAnchor.constraint(equalTo: leadingAnchor), search.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 5), mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5), mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5), mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            mainTableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5), mainTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), mainTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0), mainTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
    }
}

