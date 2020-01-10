//
//  ConsumerCartViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ConsumerCartViewController: UIViewController {
    
    var farmer: Farmer?
    var consumer: Consumer?
    @IBOutlet weak var orderSummaryLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var orderSummaryTextView: UITextView!
    @IBOutlet weak var itemsTotalLabel: UILabel!
    @IBOutlet weak var priceTotalLabel: UILabel!
    
    @IBOutlet weak var processPaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        orderSummaryLabel.layer.cornerRadius = 25
        blueView.layer.cornerRadius = 15
        processPaymentButton.layer.cornerRadius = 20
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
