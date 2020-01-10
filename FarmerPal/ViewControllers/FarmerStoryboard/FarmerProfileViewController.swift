//
//  FarmerProfileViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerProfileViewController: UIViewController {

    var farmer: Farmer?
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        blueView.layer.cornerRadius = 10
        
        guard let farmer = farmer,
            let firstName = farmer.firstName,
            let lastName = farmer.lastName,
            let phoneNum = farmer.phoneNum,
            let email = farmer.email else { return }
        
        fullNameLabel.text = firstName + " " + lastName
        phoneNumberLabel.text = phoneNum
        emailLabel.text = email
    }
}
