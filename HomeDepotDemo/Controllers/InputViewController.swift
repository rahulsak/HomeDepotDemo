//
//  InputViewController.swift
//  HomeDepotDemo
//
//  Created by Rahul S on 6/24/18.
//  Copyright © 2018 Rahul S. All rights reserved.
//

import UIKit


class InputViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtPageNumber: UITextField!
    @IBOutlet weak var txtPerPageCount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let companyName = txtCompany.text!
        let pageNumber = txtPageNumber.text!
        let perPageCount = txtPerPageCount.text!
        
            if segue.destination is MainViewController {
                let vc = segue.destination as? MainViewController
                vc?.companyName = companyName
                vc?.page_number = Int(pageNumber)!
                vc?.per_page = Int(perPageCount)!
            }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if textField == txtCompany { // Switch focus to other text field
            txtPageNumber.becomeFirstResponder()
        }
        if textField == txtPageNumber { // Switch focus to other text field
            txtPerPageCount.becomeFirstResponder()
        }
        
        return true
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
