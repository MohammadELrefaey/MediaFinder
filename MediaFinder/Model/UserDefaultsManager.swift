//
//  UserDefaults.swift
//  MediaFinder
//
//  Created by Mohamed on 12/20/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation
class UserDefaulsManager{
    private static let sharedInstance = UserDefaulsManager()
    
    static func shared() -> UserDefaulsManager {
        return UserDefaulsManager.sharedInstance
    }
    
    func set(user: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.User)
        }
    }

    func get() -> User? {
        if let savedUser = UserDefaults.standard.object(forKey: UserDefaultsKeys.User) as? Data {
                  let decoder = JSONDecoder()
                  if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                       return loadedUser
                  }
               }
               return nil
    }

}
