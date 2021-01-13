//
//  MediaResponse.swift
//  MediaFinder
//
//  Created by Mohamed on 1/4/21.
//  Copyright © 2021 Refa3y. All rights reserved.
//

import Foundation
struct MediaResponse: Codable {
    var resultCount: Int
    var results: [Media]
}
