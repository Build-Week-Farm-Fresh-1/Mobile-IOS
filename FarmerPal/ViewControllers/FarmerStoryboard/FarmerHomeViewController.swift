//
//  FarmerHomeViewController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FarmerHomeViewController: UIViewController {
    
    var farmer: Farmer?
    var consumer: Consumer?
//    let controller: Controller?
    
    @IBOutlet weak var welcomeUserLabel: UILabel!
    @IBOutlet weak var pendingOrdersLabel: UILabel!
    @IBOutlet weak var itemsInInventoryLabel: UILabel!
    @IBOutlet weak var itemsOnSaleLabel: UILabel!
    
    @IBOutlet weak var myProfileButton: UIButton!
    @IBOutlet weak var addNewProduceButton: UIButton!
    @IBOutlet weak var produceOnSale: UIButton!
    @IBOutlet weak var pendingOrders: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func myProfileButtomTapped(_ sender: UIButton) {
    }
    
    @IBAction func addNewProduceButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func produceOnSaleButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func pendingOrdersButtonTapped(_ sender: UIButton) {
    }
    
    func updateViews() {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        myProfileButton.layer.cornerRadius = 20
        addNewProduceButton.layer.cornerRadius = 20
        produceOnSale.layer.cornerRadius = 20
        pendingOrders.layer.cornerRadius = 20
        
        guard let farmer = farmer else { return }
        
        welcomeUserLabel.text = "Welcome \(farmer.firstName)"
                
        pendingOrdersLabel.text = "\(10) Pending Orders"
        itemsInInventoryLabel.text = "\(10) Items in Inventory"
        itemsOnSaleLabel.text = "\(10) Items on Sale"
    }
    
    // MARK: - Navigation
    //TODO: Use the controller to pass around the array of orders and Produces accordinly

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FarmerProfileSegue" {
            
            let farmerProfileVC = segue.destination as? FarmerProfileViewController
            farmerProfileVC?.farmer = farmer
        }
        else if segue.identifier == "AddNewProduceSegue" {
            
            if let addProduceVC = segue.destination as? AddProduceViewController {
                
                addProduceVC.farmer = farmer
            }
        }
        else if segue.identifier == "FarmerProduceOnSaleSegue" {
            
            if let farmerProducesTableVC = segue.destination as? FarmerProducesTableViewController {
                
                farmerProducesTableVC.farmer = farmer
            }
        }
        else if segue.identifier == "DisplayOrdersSegue" {
            
            if let farmerOrdersTableVC = segue.destination as? FarmerOrdersTableViewController {
                
                farmerOrdersTableVC.farmer = farmer
            }
        }
    }
}
