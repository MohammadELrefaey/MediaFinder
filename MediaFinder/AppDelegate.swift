//
//  AppDelegate.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func setRootVC() {
        let userData = UserDefaults.standard.object(forKey: "User")
        let loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if userData != nil {
            if loggedIn {
            let rootVC = sb.instantiateViewController(identifier: "profileVC") as! ProfileVC
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationController
            }
            
            else {
                let rootVC = sb.instantiateViewController(identifier: "loginVC") as! LoginVC
                let navigationController = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = navigationController
            }
        }
//        else {
//        let rootVC = sb.instantiateViewController(identifier: "login") as! RegisterationVC
//        let navigationController = UINavigationController(rootViewController: rootVC)
//        window?.rootViewController = navigationController
//        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        return true
    }
}

