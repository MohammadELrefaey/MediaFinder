//
//  File.swift
//  MediaFinder
//
//  Created by Mohamed on 11/17/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation
public struct User: Codable {
    
    enum Gender : String {
        case Male
        case Female
    }
    
    var email: String!
    var password: String!
    var name: String!
    var address: String!
    var phone: String!
    var gender: String!
    var mediaArray: [Media]!
}
