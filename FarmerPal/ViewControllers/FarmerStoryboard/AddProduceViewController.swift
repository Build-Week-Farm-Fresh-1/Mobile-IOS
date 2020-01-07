//
//  AddProduceViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AddProduceViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var isForSaleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
    }
    
    func changeProduceSaleStatus() {
        
        if isForSaleSegmentedControl.selectedSegmentIndex == 0 {
            
        } else {
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
