//
//  ConsumerHomeViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ConsumerHomeViewController: UIViewController {
    
    var consumer: Consumer?
    var apiController: APIController?
    var bearer: Bearer?
    
    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var shopByZipcodeButton: UIButton!
    @IBOutlet weak var myProfileButton: UIButton!
    @IBOutlet weak var numOfItemsInCartButton: UIButton!
    @IBOutlet weak var orderHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func shopByZipcodeButtonTapped(_ sender: UIButton) {
        
        if zipcodeTextField.text != "" {
//            performSegue(withIdentifier: "ShowFarmersByZipcodeSegue", sender: self)
        } else { return }
    }

    func updateViews() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        shopByZipcodeButton.layer.cornerRadius = 10
        myProfileButton.layer.cornerRadius = 20
        numOfItemsInCartButton.layer.cornerRadius = 20
        orderHistoryButton.layer.cornerRadius = 20
        
        guard let consumer = consumer else { return }
        
        welcomeUserLabel.text = "Welcome \(consumer.username)"
        numOfItemsInCartButton.titleLabel?.text = "8 Items in Cart"
    }
    
    // MARK: - Navigation
    //TODO: Use the controller to pass around the array of orders and Produces accordinly
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFarmersByZipcodeSegue" {
            
            if let consumerFarmerOptionsVC = segue.destination as? ConsumerFarmersOptionsTableViewController{
                
                consumerFarmerOptionsVC.consumer = consumer
                consumerFarmerOptionsVC.apiController = apiController
            }
        }
        else if segue.identifier == "ConsumerProfileSegue" {
            
            if let consumerProfileVC = segue.destination as? ConsumerProfileViewController {
                
                consumerProfileVC.consumer = consumer
                consumerProfileVC.apiController = apiController
            }
        }
        else if segue.identifier == "ConsumerCartSegue" {
            
            if let consumerCartVC = segue.destination as? ConsumerCartViewController {
                
                consumerCartVC.consumer = consumer
                consumerCartVC.apiController = apiController
            }
        }
        else if segue.identifier == "ConsumerOrderHistorySegue" {
            
            if let consumerOrderHistoryTVC = segue.destination as? ConsumerOrderHistoryTableViewController {
                
                consumerOrderHistoryTVC.consumer = consumer
                consumerOrderHistoryTVC.apiController = apiController
            }
        }
    }
}
