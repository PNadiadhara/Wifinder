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
        self.launchView.launchImage.backgroundColor = #colorLiteral(red: 1, green: 0.8813299537, blue: 0.5384758115, alpha: 1)
        self.launchView.launchImage.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.addSubview(launchView)
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.8813299537, blue: 0.5384758115, alpha: 1)
        self.view.isOpaque = true
        
    }
    

    

}
