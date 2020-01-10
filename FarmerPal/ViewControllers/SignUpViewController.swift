//
//  SignUpViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let apiController = APIController()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var farmerButton: UIButton!
    @IBOutlet weak var clientButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpBlueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumTextField.delegate = self
        zipCodeTextField.delegate = self
        self.hideKeyboardWhenTappedAround() 
        updateViews()
    }
    
    @IBAction func farmerButtonTapped(_ sender: UIButton) {
        signUpBlueView.layer.cornerRadius = 10
        showTextFields()
        clientButton.alpha = 0
        farmerButton.backgroundColor = UIColor(displayP3Red: 125/255, green: 174/255, blue: 205/255, alpha: 1)
        farmerButton.titleLabel?.tintColor = .white
        signUpBlueView.alpha = 1
    }
    
    @IBAction func clientButtonTapped(_ sender: UIButton) {
        signUpBlueView.layer.cornerRadius = 10
        showTextFields()
        farmerButton.alpha = 0
        clientButton.backgroundColor = UIColor(displayP3Red: 125/255, green: 174/255, blue: 205/255, alpha: 1)
        clientButton.titleLabel?.tintColor = .white
        signUpBlueView.alpha = 1
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        registerNewUser()
    }
    
    func registerNewUser() {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showErrorAlert(errorMessage: error!)
        } else {
            
            
            // Create clean version of data entry
            guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let phoneNum = phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let city = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let state = stateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let zipCode = zipCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            // MARK: SignUp/Create New Farmer/Consumer
            
            if farmerButton.alpha == 0 {
                
                // Registering Consumer
                apiController.registerConsumer(username: username, password: password, city: city, state: state, zipCode: zipCode, email: email, firstName: firstName, lastName: lastName, phoneNum: phoneNum) { (error) in
                    
                    if let error = error {
                        self.showErrorAlert(errorMessage: "Sign up Unsuccessful. Please try again")
                        NSLog("Error registering Consumer: \(error)")
                    } else {
                        
                        self.apiController.createConsumer(username: username, password: password, id: "", city: city, state: state, zipCode: zipCode, profileImgURL: nil, context: CoreDataStack.shared.mainContext)
                        
                        DispatchQueue.main.async {
                            
                            self.transitionToHomePage()
                        }
                    }
                }
            } else if clientButton.alpha == 0 {
                
                // Registering Farmer
                apiController.registerFarmer(username: username, password: password, city: city, state: state, zipCode: zipCode, email: email, firstName: firstName, lastName: lastName, phoneNum: phoneNum) { (error) in
                    
                    if let error = error {
                        self.showErrorAlert(errorMessage: "Sign up Unsuccessful. Please try again")
                        NSLog("Error registering Farmer: \(error)")
                    } else {
                        
                        self.apiController.createFarmer(username: username, password: password, id: "", city: city, state: state, zipCode: zipCode, profileImgURL: nil, farmImgURL: nil, context: CoreDataStack.shared.mainContext)
                        
                        DispatchQueue.main.async {
                            
                            self.transitionToHomePage()
                        }
                    }
                }
            }
        }
    }
    
    // Validate that the data is correct.
    // If correct -> return nil. If incorrect -> return error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            stateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            zipCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure enough
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    func isPasswordValid(_ password: String) -> Bool {
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
    
    func transitionToHomePage() {
        
        if clientButton.alpha == 0 {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            performSegue(withIdentifier: .singInToFarmerHomeSegue, sender: self)
            
        } else if farmerButton.alpha == 0 {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            performSegue(withIdentifier: .singInToConsumerHomeSegue, sender: self)
            
        } else {
            NSLog("Couldn't transition to correct HomePageVC")
        }
    }
    
    // MARK: Update Views
    func updateViews() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 30/255, green: 41/255, blue: 77/255, alpha: 1)
        
        hideTextFields()
        farmerButton.layer.cornerRadius = 15
        clientButton.layer.cornerRadius = 15
        signUpButton.layer.cornerRadius = 20
        signUpBlueView.alpha = 0
    }
    
    func hideTextFields() {
        firstNameTextField.alpha = 0
        lastNameTextField.alpha = 0
        phoneNumTextField.alpha = 0
        usernameTextField.alpha = 0
        passwordTextField.alpha = 0
        cityTextField.alpha = 0
        emailTextField.alpha = 0
        stateTextField.alpha = 0
        zipCodeTextField.alpha = 0
    }
    
    func showTextFields() {
        firstNameTextField.alpha = 1
        lastNameTextField.alpha = 1
        phoneNumTextField.alpha = 1
        usernameTextField.alpha = 1
        passwordTextField.alpha = 1
        cityTextField.alpha = 1
        emailTextField.alpha = 1
        stateTextField.alpha = 1
        zipCodeTextField.alpha = 1
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SingInToFarmerHomeSegue" {
            
            if let farmerHomeVC = segue.destination as? FarmerHomeViewController {
                farmerHomeVC.farmer = apiController.farmer
                farmerHomeVC.apiController = apiController
            }
        } else if segue.identifier == "SingInToConsumerHomeSegue" {
            
            if let consumerHomeVC = segue.destination as? ConsumerHomeViewController {
                consumerHomeVC.consumer = apiController.consumer
                consumerHomeVC.apiController = apiController
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Mobile validation
        if textField == phoneNumTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == zipCodeTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
