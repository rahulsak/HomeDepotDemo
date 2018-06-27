//
//  GridLayout.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/24/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//
// Collection view Flow Layout for Grid and List View 

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    private var numberOfColumns: Int = 2
    
    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        
        self.numberOfColumns = numberOfColumns
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                let itemHeight: CGFloat = 150.0
                return CGSize(width: itemWidth, height: itemHeight)
            }
            return CGSize(width: 150, height: 150)
        }
        set {
            super.itemSize = newValue
        }
    }
}

