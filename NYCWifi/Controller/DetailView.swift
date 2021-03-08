//
//  DetailView.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/26/21.
//

import UIKit
import MapKit

class DetailView: UIView {
    var gradient: CAGradientLayer!
    
    public lazy var mapKitView: MKMapView = {
        let mkv = MKMapView()
        mkv.layer.cornerRadius = 10
        mkv.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.4784313725, alpha: 1)
        mkv.layer.borderWidth = 3
        return mkv
    }()
    
    public lazy var infoTextView: UITextView = {
        let tv = UITextView()
        tv.dataDetectorTypes = [.address]
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setUpDetailViewBackground()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpDetailViewBackground () {
        backgroundColor = .white
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(displayP3Red: 56/255, green: 163/255, blue: 165/255, alpha: 1).cgColor,
                           UIColor(displayP3Red: 87/255, green: 204/255, blue: 153/255, alpha: 1).cgColor,
                           UIColor(displayP3Red: 128/255, green: 237/255, blue: 153/255, alpha: 1).cgColor]
        layer.addSublayer(gradient)
        
    }
    
    private func setConstraints() {
        addSubview(mapKitView)
        addSubview(infoTextView)
        
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        
        mapKitView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        mapKitView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 11).isActive = true
        mapKitView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -11).isActive = true
        mapKitView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        infoTextView.topAnchor.constraint(equalTo: mapKitView.bottomAnchor, constant: 11).isActive = true
        infoTextView.leadingAnchor.constraint(equalTo: mapKitView.leadingAnchor).isActive = true
        infoTextView.trailingAnchor.constraint(equalTo: mapKitView.trailingAnchor).isActive = true
        infoTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -11).isActive = true
    }
}
