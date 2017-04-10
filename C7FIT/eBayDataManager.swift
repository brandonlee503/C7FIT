//
//  EbayDataManager.swift
//  C7FIT
//
//  Created by Brandon Lee on 2/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

struct EbayDataManager {

    // MARK: - Constants

    let browseAPIbaseURL = "https://api.ebay.com/buy/browse/v1/"

    // MARK: - Network Requests

    /**
        Fetches an item based off of its ID.
         - Parameter itemID: ItemID
         - Returns completion: A callback that returns the item JSON
     */
    func getItem(itemID: String, OAuth2Token: String, completion: @escaping ([String: Any]?) -> Void) {
        let headers = [
            "authorization": OAuth2Token
        ]
        let urlEncodedString = "\(browseAPIbaseURL)item/\(itemID)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlEncodedString)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, _, error) in
            guard let data = data, error == nil else {
                print("Error in retrieving item: \(String(describing: error?.localizedDescription))")
                return completion(nil)
            }
            guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                let dataDict = dataJSON as? [String: Any] else {
                return completion(nil)
            }

            DispatchQueue.main.async {
                completion(dataDict)
            }
        }

        dataTask.resume()
    }

    /**
        Fetches a list of items based off of a search query with a limit of 10 items.
        - Parameter query: The item search query
        - Returns completion: A callback that returns an EbayItemCategory model
     */
    func searchItem(query: String, OAuth2Token: String, completion: @escaping(EbayItemCategory?) -> Void) {
        let headers = [
            "authorization": OAuth2Token
        ]
        let urlEncodedString = "\(self.browseAPIbaseURL)item_summary/search?q=\(query)&limit=10"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlEncodedString)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, _, error) in
            guard let data = data, error == nil else {
                print("Error in retrieving item: \(String(describing: error?.localizedDescription))")
                return completion(nil)
            }
            guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []),
                let dataDict = dataJSON as? [String: Any] else {
                return completion(nil)
            }

            // Convert raw JSON into respective models, TODO: - Potentially decouple this in the future...
            guard let items = dataDict["itemSummaries"] as? [[String: Any]] else { return }

            var itemArray = [EbayItem]()
            for item in items {
                let newItem = EbayItem(itemJSON: item)
                itemArray.append(newItem)
            }

            DispatchQueue.main.async {
                completion(EbayItemCategory(title: query, items: itemArray))
            }
        }

        dataTask.resume()
    }
}
