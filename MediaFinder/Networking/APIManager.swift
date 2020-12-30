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
    static func loadMovies(completion: @escaping (_ error: Error?, _ movies: [Media]?) -> ()) {
          
                Alamofire.request("https://api.androidhive.info/json/movies.json", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
                    
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
                        let moviesArr = try JSONDecoder().decode([Media].self, from: data)
                        completion(nil, moviesArr)
                    } catch let error {
                        print (error)
                    }
                }
      
      }
}
