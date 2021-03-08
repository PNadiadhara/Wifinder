//
//  LaunchViewController.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 3/2/21.
//

import UIKit

class LaunchViewController: UIViewController {

    let launchView = LaunchView()
    
    override func viewWillLayoutSubviews() {
        self.launchView.launchImage.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.9764705882, blue: 0.8, alpha: 1)
        self.launchView.launchImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addSubview(launchView)
        self.view.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.9764705882, blue: 0.8, alpha: 1)
        self.view.isOpaque = true
        
    }
    

    

}
