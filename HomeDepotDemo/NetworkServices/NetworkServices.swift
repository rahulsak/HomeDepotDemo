//
//  NetworkServices.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/25/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//

import UIKit


class NetworkServices:NSObject {
    
    // Get the schedule data from server
    
    static func getCompanyData(baseURL:String,completion:@escaping ((Data)->())) {
        let baseUrl = baseURL
        print("baseUrl = \(baseURL)")
        
        let request = NSMutableURLRequest(url: NSURL(string: baseUrl)! as URL)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
                guard error == nil else {
                    return print("Error: \(String(describing: error?.localizedDescription))")
                }
                guard let data = data else {
                    return print("Data is empty")
                }
                guard let response = response else {
                    return print("Response is empty")
                }
            
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    completion(data)
                }else {
                print("Failed to get data. StatusCode = \(statusCode)")
                }
            }
        }
        task.resume()
    }
}

