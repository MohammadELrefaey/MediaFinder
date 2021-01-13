//
//  File.swift
//  MediaFinder
//
//  Created by Mohamed on 11/17/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation

enum Gender : String, Codable {
    case Male
    case Female
}

 struct User: Codable {
    var email: String!
    var password: String!
    var name: String!
    var address: String!
    var phone: String!
    var gender: Gender!
}
