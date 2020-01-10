//
//  ConsumerHomeViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

//Intern == Follows orders -> You have to conform to a delegate(to recieve info)
class ConsumerHomeViewController: UIViewController {
    
    var farmer: Farmer?
    var consumer: Consumer?
    var apiController: APIController?
    
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
    
    func updateViews() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        shopByZipcodeButton.layer.cornerRadius = 10
        myProfileButton.layer.cornerRadius = 20
        numOfItemsInCartButton.layer.cornerRadius = 20
        orderHistoryButton.layer.cornerRadius = 20
        
        guard let consumer = consumer else { return }
        
        
    }
    
    // MARK: - Navigation
    //TODO: Use the controller to pass around the array of orders and Produces accordinly
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFarmersByZipcodeSegue" {
            
            let consumerFarmerOptionsVC = segue.destination as? ConsumerFarmersOptionsTableViewController
            consumerFarmerOptionsVC?.consumer = consumer
            //            consumerFarmerOptionsVC?.user = user
        }
        else if segue.identifier == "ConsumerProfileSegue" {
            
            if let consumerProfileVC = segue.destination as? ConsumerProfileViewController {
                
                consumerProfileVC.consumer = consumer
                //                consumerProfileVC.user = user
            }
        }
        else if segue.identifier == "ConsumerCartSegue" {
            
            if let consumerCartVC = segue.destination as? ConsumerCartViewController {
                
                consumerCartVC.consumer = consumer
                //                consumerCartVC.user = user
            }
        }
        else if segue.identifier == "ConsumerOrderHistorySegue" {
            
            if let consumerOrderHistoryTVC = segue.destination as? ConsumerOrderHistoryTableViewController {
                
                consumerOrderHistoryTVC.consumer = consumer
                //                consumerOrderHistoryTVC.user = user
            }
        }
    }
}
