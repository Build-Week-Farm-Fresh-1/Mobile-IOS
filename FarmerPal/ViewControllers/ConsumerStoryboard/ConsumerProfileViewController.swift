//
//  ConsumerProfileViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ConsumerProfileViewController: UIViewController {
    
    var farmer: Farmer?
    var consumer: Consumer?
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
//        // TODO: You have more info you can display now
//        guard let user = user,
//            let firstName = user.firstName,
//            let lastName = user.lastName,
//            let phoneNum = user.phoneNum,
//            let email = user.email else { return }
//        
//        fullNameLabel.text = firstName + " " + lastName
//        phoneNumberLabel.text = user.phoneNum
//        emailLabel.text = email
    }
}
