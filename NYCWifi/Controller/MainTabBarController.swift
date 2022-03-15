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

        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "wifi.circle.fill"), tag: 0)
        
        let savedVC = SavedViewController()

        savedVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "list.bullet.rectangle.fill"), tag: 1)
        
        let tabBarLists = [mapVC, savedVC]
        viewControllers = tabBarLists.map(UINavigationController.init)
    }
    


}
