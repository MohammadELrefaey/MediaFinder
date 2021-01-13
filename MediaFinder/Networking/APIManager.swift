//
//  APIManager.swift
//  MediaFinder
//
//  Created by Mohamed on 12/29/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation
import Alamofire
class APIManager {
    static func loadMedia(searchQuery: String, mediaType: String, completion: @escaping (_ error: Error?, _ Media: [Media]?) -> ()) {
        
        let parameters = [ParamKeys.searchQuery: searchQuery, ParamKeys.mediaType: mediaType]
          
        Alamofire.request(URLs.iTunesSearch, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { response in
                    
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
                    
            guard let data = response.data else {
                print ("didn't get any data from API")
                return
            }
                    
            do {
                let mediaArr = try JSONDecoder().decode(MediaResponse.self, from: data).results
                completion(nil, mediaArr)
                } catch let error {
                    print (error)
                }
        }
    }
}
