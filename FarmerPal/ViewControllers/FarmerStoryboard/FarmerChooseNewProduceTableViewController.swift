//
//  FarmerChooseNewProduceTableViewController.swift
//  FarmerPal
//
//  Created by macbook on 1/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class FarmerChooseNewProduceTableViewController: UITableViewController {
    
    var farmer: Farmer?
    var bearer: Bearer?
    var apiController: APIController?
    var produceOptionsForFarmer: [ProduceRepresentation]?
    
    var produceQuantity: Int16?
    var producePrice: Double?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Produce> = {
        
        let fetchRequest: NSFetchRequest<Produce> = Produce.fetchRequest()
        
        // YOU MUST make the descriptor with the same key path as the sectionNameKeyPath be the first sort descriptor in this array
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "name",
                                             cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch() // Fetch the produce options for farmer
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        fetchProduceOptions()
    }
    
    func fetchProduceOptions() {
        apiController?.fetchProduceOptionsForFarmer(completion: { (result) in
            
            do {
                let produceOptions = try result.get()
                DispatchQueue.main.async {
                    self.produceOptionsForFarmer = produceOptions
                    self.tableView.reloadData()
                    
                }
            } catch {
                if let error = error as? NetworkingError {
                    NSLog("Error fetching produce options: \(error)")
                } else {
                    NSLog("Error fetching produce options: \(error)")
                }
            }
            
        })
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return produceOptionsForFarmer?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FarmerProduceOptionCell", for: indexPath)
        
        guard let produce = produceOptionsForFarmer?[indexPath.row] else { return cell }
        cell.textLabel?.text = produce.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let farmer = farmer else { return }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        guard let produceOptions = produceOptionsForFarmer?[indexPath.row] else { return }
        
        self.getPriceAndQuantityAlert( { (success) in
            
            guard success == true else {
                self.showErrorAlert()
                return
            }
            
            guard let price = self.producePrice,
                let quantity = self.produceQuantity else {
                    
                    self.showErrorAlert()
                    return
            }
            
            self.apiController?.addProduceToFarmerInventory(produce: produceOptions, farmer: farmer, quantity: quantity, price: price, completion: { (result) in
                
                do {
                    _ = try result.get()
                    DispatchQueue.main.async {
                        cell.accessoryType = .checkmark
                    }
                } catch {
                    
                    DispatchQueue.main.async {
                        self.showErrorAlert()
                        NSLog("Error adding new produce to Inventory: \(error)")
                        cell.accessoryType = .none
                    }
                }
            })
        })
    }
    
    // Getting the price and quantity of a produce
    func getPriceAndQuantityAlert(_ completion: @escaping (_ success: Bool) -> Void) {
        
        let alert = UIAlertController(title: "Details", message: nil, preferredStyle: .alert)
        
        let produceDetailsAction = UIAlertAction(title: "Add produce", style: .default, handler: { (action) -> Void in

            let quantityTextField = alert.textFields![0]
            let priceTextField = alert.textFields![1]

            guard let quantity = quantityTextField.text,
                let price = priceTextField.text else { return }

            self.produceQuantity = Int16(quantity)
            self.producePrice = Double(price)
            completion(true)

        })

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            completion(false)
        })

        alert.addTextField(configurationHandler: { (textFiled: UITextField) in

            textFiled.placeholder = "Quantity"
            textFiled.keyboardType = .default
        })

        alert.addTextField(configurationHandler: { (textField: UITextField) in

            textField.placeholder = "Price"
            textField.keyboardType = .default

        })

        alert.addAction(produceDetailsAction)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error adding produce", message: "Please refresh page and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in })
        
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
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

extension FarmerChooseNewProduceTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            
            tableView.moveRow(at: indexPath, to: newIndexPath)
            //            tableView.deleteRows(at: [indexPath], with: .automatic)
        //            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            return
        }
    }
}
