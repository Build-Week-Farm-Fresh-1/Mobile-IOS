//
//  FarmerOrderDetailViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerOrderDetailViewController: UIViewController {
    
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var clientPhoneNumLabel: UILabel!
    @IBOutlet weak var producesListTextView: UITextView!
    @IBOutlet weak var priceTotalLabel: UILabel!
    
    @IBOutlet weak var readyForPickupSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func processPaymentButtonPressed(_ sender: UIButton) {
    }
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(false, animated: true)
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
