//
//  CollectionViewCell.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/24/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//Custom collection View 

import UIKit

class CollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblLicense: UILabel!
    
    func displayContents(name: String, description:String, strDate:String, licenseName:String){
        lblName.text = name
        lblDescription.text = description
        lblDate.text = strDate
        lblLicense.text = licenseName
    }
}
