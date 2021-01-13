//
//  AppDelegate.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mediaArray: [Media] = [Media]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        IQKeyboardManager.shared.enable = true
        audioSession()
        
        SQLiteManager.shared().DataBaseSetup()
        SQLiteManager.shared().creatUserTable()
        SQLiteManager.shared().creatSearchTable()
        SQLiteManager.shared().creatMediaTypeTable()

        return true
    }
}

//MARK:- Private Methods
extension AppDelegate {
    private func setRootVC() {
        let userData = UserDefaults.standard.object(forKey: UserDefaultsKeys.User)
        let loggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        
        if userData != nil {
            if loggedIn {
                let rootVC = sb.instantiateViewController(identifier: ViewContoller.MediaListVC) as! MediaListVC
                let navigationController = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = navigationController
            } else {
                let rootVC = sb.instantiateViewController(identifier: ViewContoller.LoginVC) as! LoginVC
                let navigationController = UINavigationController(rootViewController: rootVC)
                window?.rootViewController = navigationController
            }
        }
    }
    private func audioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
           try audioSession.setCategory(.playback, mode: .moviePlayback)
        } catch {
            print(error.localizedDescription)
        }
    }
}
    
    
