//
//  DataAPL.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import Foundation
import Alamofire

// Getting data and parse
class DatabaseInfo: NSObject{
    static let shared = DatabaseInfo()
    private let baseUrl = "http://nas.er.usgs.gov/api/v1"
    
    func getFishes(searchFish: String,searchState: String,completion: @escaping (_ sealife: [[String : Any]]?) -> Void) -> Request? {
        
        if  let validURL = URL(string: baseUrl + "/occurrence/search?county=\(searchFish)&state=\(searchState)") {
            let request = Alamofire.request(validURL)
            request.responseJSON(completionHandler: { (response) in
                debugPrint(response)
                if let responseJSON = response.result.value as? [String:Any] {
                    if let results = responseJSON["results"] as? [[String : Any]] {
                        
                        completion(results)
                    }
                    else {
                        completion(nil)
                    }
                }
                else {
                    completion(nil)
                }
                
            })
            return request
        }
        else {
            completion(nil)
        }
        return nil
    }
    
}

