//
//  LoginViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
        
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        
        if userTypeSegmentedControl.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: .loginToFarmerHomeSegue, sender: self)
            
        } else if userTypeSegmentedControl.selectedSegmentIndex == 1 {
            performSegue(withIdentifier: .loginToConsumerHomeSegue, sender: self)
        }
    }
    
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
    
    
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "FarmerHomePageSegue" {
//            
//            segue.destination as? FarmerHomeViewController
//                      
//        } else if segue.identifier == "ConsumerHomePageSegue" {
//            
//            segue.destination as? ConsumerHomeViewController
//
//        }
//    }
}
