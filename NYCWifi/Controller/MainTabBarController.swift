//
//  MainTabBarController.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 3/1/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapVC = MapViewController()
//TODO: - UIImage named wifi update
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "Wifi"), tag: 0)
        
        let savedVC = SavedViewController()
//TODO: - UIImage named wifi update
        savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(named: "Saved"), tag: 1)
        
        let tabBarLists = [mapVC, savedVC]
        viewControllers = tabBarLists.map(UINavigationController.init)
    }
    


}
