//
//  AddProduceViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AddProduceViewController: UIViewController {
    
    var farmer: Farmer?
    var apiController: APIController?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var isForSaleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let name = nameTextField.text,
            let price = priceTextField.text,
            let description = descriptionTextView.text else { return }
        
        
    }
    
    func changeProduceSaleStatus() {
        
        if isForSaleSegmentedControl.selectedSegmentIndex == 0 {
            
        } else {
            
        }
    }
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        descriptionTextView.text = ""
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
