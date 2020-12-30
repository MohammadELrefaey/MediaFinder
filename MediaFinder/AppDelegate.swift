//
//  AppDelegate.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func setRootVC() {
        let userData = UserDefaults.standard.object(forKey: UserDefaultsKeys.User)
        let loggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if userData != nil {
            if loggedIn {
                let rootVC = sb.instantiateViewController(identifier: VC.MediaListVC) as! MediaListVC
            let navigationController = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navigationController
            }
            
            else {
                let rootVC = sb.instantiateViewController(identifier: VC.LoginVC) as! LoginVC
                let navigationController = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = navigationController
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        IQKeyboardManager.shared.enable = true

        return true
    }
}

