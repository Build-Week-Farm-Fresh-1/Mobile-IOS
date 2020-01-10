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
    var consumer: Consumer?
    
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
        
//        guard let user = user,
//            let firstName = user.firstName,
//            let lastName = user.lastName,
//            let phoneNum = user.phoneNum,
//            let email = user.email else { return }
//        
//        fullNameLabel.text = firstName + " " + lastName
//        phoneNumberLabel.text = phoneNum
//        emailLabel.text = email
    }
}
