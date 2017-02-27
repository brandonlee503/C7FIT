//
//  eBayDataManager.swift
//  C7FIT
//
//  Created by Brandon Lee on 2/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

struct eBayDataManager {
    
    // MARK: - Constants
    
    let encodedOAuthCreds = "<INSERT CREDENTIALS HERE>"
    let clientKey = "<INSERT CREDENTIALS HERE>"
    let authorizeURL = "https://api.sandbox.ebay.com/identity/v1/oauth2/token"
    let eBayRedirectURLName = "<INSERT CREDENTIALS HERE>"
    
    /**
        Obtain a new bearer token
        - Returns completion: A callback that returns an optional string token
     */
    func getOAuth2Token(completion: @escaping (_:String?) -> Void) {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "authorization": "Basic \(encodedOAuthCreds)",
            "cache-control": "no-cache"
        ]
        
        let url = URL(string: "\(authorizeURL)?grant_type=client_credentials&redirect_uri=https%3A%2F%2Fsignin.sandbox.ebay.com%2Fauthorize%3Fclient_id%3D\(clientKey)%26response_type%3Dcode%26redirect_uri%3D\(eBayRedirectURLName)%26scope%3Dhttps%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fbuy.order.readonly%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fbuy.guest.order%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.marketing.readonly%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.marketing%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.inventory.readonly%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.inventory%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.account.readonly%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.account%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.fulfillment.readonly%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.fulfillment%20https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope%2Fsell.analytics.readonly&scope=https%3A%2F%2Fapi.ebay.com%2Foauth%2Fapi_scope")!
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.downloadTask(with: request as URLRequest) { (location, response, error) in
            guard let location = location, error == nil else {
                print("Error in retrieving bearer token: \(error?.localizedDescription)")
                return
            }
            
            guard let dataObject = try? Data(contentsOf: location), let dataJSON = try? JSONSerialization.jsonObject(with: dataObject, options: []) else {
                return
            }
            
            guard let dataDict = dataJSON as? [String: Any], let token = dataDict["access_token"] as? String else {
                return
            }
            
            completion(token)
        }
        
        dataTask.resume()
    }
  
}
