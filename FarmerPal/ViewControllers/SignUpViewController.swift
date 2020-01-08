//
//  SignUpViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // TODO: Comment this back in when ready to Network
//    let userController = UserController()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var farmerButton: UIButton!
    @IBOutlet weak var clientButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpBlueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumTextField.delegate = self
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
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showErrorAlert(errorMessage: error!)
        } else {
            
            // MARK: Create New User
            var userType: UserType = .farmer
            
            if farmerButton.alpha == 0 {
                userType = .consumer
            } else if clientButton.alpha == 0 {
                userType = .farmer
            } else {
                // TODO: Take this else statement out when everything works properly
                print("Did not assign type of user before creating user")
            }
            
            // Create clean version of data
            guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let phoneNum = phoneNumTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
            
            // MARK: Creating User in Firebase
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in //TODO: Probably need completion
                
                if error != nil {
                    self.showErrorAlert(errorMessage: "Error creating User")
                    //completion
                }
                else {
                    // User created successfuly, now store the properties
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName,
                                                              "lastName": lastName,
                                                              "id": result!.user.uid,
                                                              "username": username,
                                                              "password": password,
                                                              "phoneNum": phoneNum,
                                                              "email": email,
                                                              "userType": userType.rawValue]) { (error) in
                        
                        if let error = error {
                            print("Error adding document's data: \(error)")
                        } else {
                            print("User with ID: \(result!.user.uid) saved with data succefully")
                        }
                    }
                    self.transitionToHomePage()
                }
            }
//
//            /*
//             TODO: Comment this back in when ready to network
//
//             // Create the user & PUT it in Server
//             userController.createUser(username: username, password: password, isLoggedIn: true, firstName: firstName, lastName: lastName, phoneNum: Int16(phoneNum)!, email: email, userType: userType.rawValue, context: CoreDataStack.shared.mainContext)
//             */
//
//            // MARK: Transition to HomePage
//            transitionToHomePage()
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
            addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
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
    
    func transitionToHomePage() {
        
        // TODO: Wilma -> min 1:10 change rootViewController
        if clientButton.alpha == 0 {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            performSegue(withIdentifier: .singInToFarmerHomeSegue, sender: self)
            
        } else if farmerButton.alpha == 0 {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            performSegue(withIdentifier: .singInToConsumerHomeSegue, sender: self)
            
        } else {
            print("Couldn't transition to correct HomePageVC")
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
        addressTextField.alpha = 0
        emailTextField.alpha = 0
    }
    
    func showTextFields() {
        firstNameTextField.alpha = 1
        lastNameTextField.alpha = 1
        phoneNumTextField.alpha = 1
        usernameTextField.alpha = 1
        passwordTextField.alpha = 1
        addressTextField.alpha = 1
        emailTextField.alpha = 1
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

extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Mobile validation
        if textField == phoneNumTextField {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
