//
//  Movie.swift
//  MediaFinder
//
//  Created by Mohamed on 12/19/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation

var user: User!
var mediaArray: [Media] = [Media]()

struct Media: Codable {
    var image: String!
    var name: String!
}

func bindMedia() {
   let media1 = Media(image: "SherlockHolmesImg", name: "Sherlock Holmes")
   let media2 = Media(image: "TheDarkKnightImg", name: "The Dark Knight")
   let media3 = Media(image: "TheDarkKnightRisesImg", name: "The Dark Knight Rises")
   let media4 = Media(image: "InceptionImg", name: "Inception")
   let media5 = Media(image: "InterstellarImg", name: "Interstellar")
   mediaArray = [media1,media2,media3,media4,media5]
    
    
    user.mediaArray = mediaArray
    setUserDefaults(user: user)
  
}

    

