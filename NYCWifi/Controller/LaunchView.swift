//
//  LaunchView.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 3/2/21.
//

import UIKit

class LaunchView: UIView {

    public lazy var launchImage: UIImageView = {
        let LI = UIImageView()
        LI.image = UIImage(named: "")
        LI.contentMode = .scaleAspectFit
        return LI
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(launchImage)
        
        launchImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            launchImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1), launchImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1), launchImage.centerXAnchor.constraint(equalTo: self.centerXAnchor), launchImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
}
