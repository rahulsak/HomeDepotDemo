//
//  Users.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/25/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//
// Company Data Model 

import Foundation

struct CompanyData {
    var companyId : NSNumber
    var name : String
    var companyDescription : String
    var created_at : String
    var license : License
    
    init?(json:Any) {
        guard let companyData = json as? NSDictionary else {
            return nil
        }
        
        guard let companyId = companyData["id"] as? NSNumber,
            let name = companyData["name"] as? String,
            let companyDescription = companyData["description"] as? String,
            let created_at = companyData["created_at"] as? String,
            let licenseDict = companyData["license"] as? [String: Any],
            let license = License(json: licenseDict) else {
                return nil
        }

        self.companyId = companyId
        self.name = name
        self.companyDescription = companyDescription
        self.created_at = created_at
        self.license = license
    }
    
    struct License {
        var licenseName : String
        
        init?(json:Any) {
            guard let licenseData = json as? NSDictionary else {
                return nil
            }
            guard  let licenseName = licenseData["name"] as? String else {
                return nil
            }
            self.licenseName = licenseName
        }
    }
}


