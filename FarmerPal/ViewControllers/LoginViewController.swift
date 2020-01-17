//
//  LoginViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let apiController = APIController()
    var farmer: Farmer?
    var consumer: Consumer?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginBlueView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // Validate the textFileds
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            showErrorAlert(errorMessage: error!)
        } else {
            
            // Clean version of the data
            let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if self.userTypeSegmentedControl.selectedSegmentIndex == 0 {
                
//                logIn(username: username, password: password)
                
                // MARK: Log In Farmer
                apiController.loginFarmer(username: username, password: password) { (error) in

                    if let error = error {
                        self.showErrorAlert(errorMessage: "Login Unsuccessful. Please try again")
                        NSLog("Error Login in Farmer: \(error)")
                        return
                    } else {
                        self.farmer = self.apiController.fetchFarmerFromCD(with: username)

                        DispatchQueue.main.async {

                            // MARK: Transition to HomePage
                            self.navigationController?.setNavigationBarHidden(true, animated: true)
                            self.performSegue(withIdentifier: .loginToFarmerHomeSegue, sender: self)
                        }
                    }
                }
            } else if self.userTypeSegmentedControl.selectedSegmentIndex == 1 {
                
                // MARK: Log In Consumer
                
                apiController.loginConsumer(username: username, password: password) { (error) in
                    
                    if let error = error {
                        self.showErrorAlert(errorMessage: "Login Unsuccessful. Please try again")
                    } else {
                        self.consumer = self.apiController.fetchConsumerFromCD(with: username)
                        
                        DispatchQueue.main.async {
                            
                            // MARK: Transition to HomePage
                            // TODO: Create Alert for if the LogIn was unsuccessfull
                            
                            self.navigationController?.setNavigationBarHidden(true, animated: true)
                            self.performSegue(withIdentifier: .loginToConsumerHomeSegue, sender: self)

                        }
                    }
                }
                
            }
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 30/255, green: 41/255, blue: 77/255, alpha: 1)
        
        loginBlueView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 26
        signUpButton.layer.cornerRadius = 18
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoginToFarmerHomeSegue" {
            
            if let farmerHomeVC = segue.destination as? FarmerHomeViewController {
                farmerHomeVC.farmer = farmer
                farmerHomeVC.apiController = apiController
                farmerHomeVC.bearer = apiController.bearer
            }
        } else if segue.identifier == "LoginToConsumerHomeSegue" {
            
            if let consumerHomeVC = segue.destination as? ConsumerHomeViewController {
                consumerHomeVC.consumer = consumer
                consumerHomeVC.apiController = apiController
                consumerHomeVC.bearer = apiController.bearer
            }
        }
    }
}
