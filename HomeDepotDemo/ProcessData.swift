//
//  ProcessData.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/26/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//
// Parse the JSON response using JSONSerialization

import UIKit

class ProcessData:NSObject {
    
    func parseJsonResponse(responseData:Data) -> ([CompanyData]) {
        var companyData = [CompanyData]()
        
                guard let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as? NSArray else {
                    print("Not an array")
                    return companyData
                }
                for responseData in json {
                    guard let company = CompanyData(json: responseData) else {
                        continue
                    }
                    companyData.append(company)
                }
                return companyData
    }
}
