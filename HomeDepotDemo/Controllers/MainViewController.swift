//
//  ViewController.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/24/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDataSource,UIScrollViewDelegate {

    @IBOutlet weak var viewSegementControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!

    var gridLayout: GridLayout = GridLayout(numberOfColumns: 2)    
    var companyName : String?
    var per_page : Int?
    var page_number: Int?
    var companyList = [CompanyData]()
    var layoutFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getServiceData(companyName: companyName!, page: page_number!, per_page: per_page!)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
    }

    // MARK: build and call the REST API
    func getServiceData(companyName:String,page:Int,per_page: Int ) {
        var serviceBaseURL = "https://api.github.com/users/"
        serviceBaseURL = serviceBaseURL+"\(companyName)/repos?page=\(page)&per_page=\(per_page)"
        // Call the rest api - NetworkService
        NetworkServices.getCompanyData(baseURL: serviceBaseURL) {[weak self](data) in
            // parsing the response
            let parseData = ProcessData()
            self?.companyList.append(contentsOf: parseData.parseJsonResponse(responseData: data))
            DispatchQueue.main.async {
                self!.collectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let name = companyList[indexPath.row].name
        let description = companyList[indexPath.row].companyDescription
        let createdDate = companyList[indexPath.row].created_at
        let licenseName = companyList[indexPath.row].license.licenseName
        
        if (layoutFlag) {
            cell.lblDate.isHidden = true
            cell.lblLicense.isHidden = true
        } else {
            cell.lblDate.isHidden = false
            cell.lblLicense.isHidden = false
        }
        
        cell.displayContents(name: name,description: description,strDate: createdDate, licenseName: licenseName)
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        gridLayout.invalidateLayout()
    }
    
    
   // MARK: Segment Contril - Grid-List View
    @IBAction func changeView(_ sender: Any) {
        
        switch viewSegementControl.selectedSegmentIndex{
        case 0:
            let gridLayout: GridLayout = GridLayout(numberOfColumns: 2)
            collectionView.collectionViewLayout = gridLayout
            layoutFlag = true
            collectionView.reloadData()
            
        case 1:
            let gridLayout: GridLayout = GridLayout(numberOfColumns: 1)
            collectionView.collectionViewLayout = gridLayout
            layoutFlag = false
            collectionView.reloadData()
        default:
            break
        }
    }
    
    // MARK: Scroll View
    // getting called when reach bottom of the scroll view or top of the scroll view
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let scrollOffsetY = scrollView.contentOffset.y
        if(scrollOffsetY < 0){
            //Pulling down
            print("Pulling down")
        }
        else if(scrollOffsetY >= (3/4) * scrollView.contentSize.height - (3/4) * scrollView.frame.size.height){
            //Pulling up
            page_number = page_number! + 1
            getServiceData(companyName: companyName!, page: page_number!, per_page: per_page!)
        }
    }
}

