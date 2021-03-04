//
//  AppDelegate.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var launchScreenVC = LaunchViewController()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        launchScreen()
        return true
    }
    private func launchScreen() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = launchScreenVC
        self.window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(dismissLaunchScreen), userInfo: nil, repeats: false)
    }
    
    @objc func dismissLaunchScreen() {

                window = UIWindow.init(frame: UIScreen.main.bounds)
                window?.rootViewController = MainTabBarController()
                window?.makeKeyAndVisible()
               self.window?.tintColor = #colorLiteral(red: 0.9980230927, green: 0.5507860184, blue: 0.5175441504, alpha: 1)
    }

    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

