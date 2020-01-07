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

    }
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        
        // Validate the textFileds
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showErrorAlert(errorMessage: error!)
        } else {
            
            // Clean version of the data
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // MARK: Log In the User
            // TODO: Add some NETWORKING to Log in the user
            // TODO: Create Alert for if the LogIn was unsuccessfull
            
            // MARK: Transition to HomePage
            
            if userTypeSegmentedControl.selectedSegmentIndex == 0 {
                navigationController?.setNavigationBarHidden(true, animated: true)
                performSegue(withIdentifier: .loginToFarmerHomeSegue, sender: self)
                
            } else if userTypeSegmentedControl.selectedSegmentIndex == 1 {
                navigationController?.setNavigationBarHidden(true, animated: true)
                performSegue(withIdentifier: .loginToConsumerHomeSegue, sender: self)
            }
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure enough
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        // 1 - Password length is 8.
        // 2 - One Alphabet in Password.
        // 3 - One Special Character in Password.
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
