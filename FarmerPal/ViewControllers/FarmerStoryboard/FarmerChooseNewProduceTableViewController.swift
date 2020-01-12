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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
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
        
        
        // Unselect the row, and instead, show the state with a checkmark.
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        // Update the selected item to indicate whether the user packed it or not.
        let produce = produceOptionsForFarmer?[indexPath.row]
//        let newItem = PackingItem(name: item.name, isPacked: !item.isPacked)
//        packingList.remove(at: indexPath.row)
//        packingList.insert(newItem, at: indexPath.row)
        
        // Show a check mark next to packed items.
//        if produce.isPacked {
            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        
//        let selectedProduce = produceOptionsForFarmer?[indexPath.row]
//
//        if let
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
