//
//  constants.swift
//  MediaFinder
//
//  Created by Mohamed on 12/25/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation

//MARK:- UserDefaultsKeys
struct UserDefaultsKeys {
    static let User = "User"
    static let isLoggedIn = "IsLoggedIn"
    static let mediaType = "mediaType"
    static let scStatus = "scStatus"
}

//MARK:- ViewContollers
struct ViewContoller {
    static let RegisterationVC = "RegisterationVC"
    static let MapVC = "MapVC"
    static let LoginVC = "LoginVC"
    static let ProfileVC = "ProfileVC"
    static let MediaListVC = "MediaListVC"
}

//MARK:- ViewContollers
struct VCTitles {
    static let Registeration = "REGISTERATION"
    static let Login = "LOGIN"
    static let Profile = "PROFILE"
    static let MediaList = "MEDIA LIST"
}

//MARK:- Storyboards
struct Storyboard {
    static let main = "Main"
}

//MARK:- Cells
struct Cell {
    static let mediaCell = "MediaCellView"
    static let reusabelIdentifier = "MediaCellView"
}

//MARK:- Urls
struct URLs {
    static let baseUrl = "https://api.androidhive.info/json/movies.json"
    static let iTunesSearch = "https://itunes.apple.com/search?"
}

//MARK:- Parameters keys
struct ParamKeys {
    static let searchQuery = "term"
    static let mediaType = "media"
}

//MARK:- mediaType
struct MediaType {
    static let music = "music"
    static let movie = "movie"
    static let tvShow = "tvShow"
}
