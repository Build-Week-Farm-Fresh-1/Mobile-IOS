//
//  FarmerProfileViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerProfileViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        
        guard let user = user,
            let firstName = user.firstName,
            let lastName = user.lastName,
            let email = user.email else { return }
        
        fullNameLabel.text = firstName + " " + lastName
        phoneNumberLabel.text = String(user.phoneNum)
        emailLabel.text = email
    }
}
