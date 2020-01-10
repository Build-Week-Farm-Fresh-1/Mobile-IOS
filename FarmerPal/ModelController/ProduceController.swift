//
//  ProduceController.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class ProduceController {
    
    var farmer: Farmer?
    var consumer: Consumer?
    
    var produce: Produce?
//    let baseURL = URL(string: "https://farmpalbw.firebaseio.com")!
//    
//    //MARK: Fetch Produce from Firebase
//
//    func fetchProduceFromServer(completion: @escaping () -> Void = { }) {
//
//        // Set up the URL
//        let requestURL = baseURL
//        .appendingPathExtension("json")
//        .appendingPathExtension("produce")
//
//        // Create the URLRequest
//        let request = URLRequest(url: requestURL)
//
//        // Perform the data task
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let error = error {
//                NSLog("Error fetching all Users: \(error)")
//                completion()
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data returned from fetch data task")
//                completion()
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            do {
//
//                let produceList = try decoder.decode([String: ProduceRepresentation].self, from: data).map({ $0.value })
//
////                // What produce need to be created, and what produce need to be updated
////                self.updateProduceList(with: produceList)
//
//            } catch {
//                NSLog("Error decoding produceRepresentations: \(error)")
//            }
//            completion()
//        }.resume()
//    }
//    
//    //MARK: UpdateUsers
//    func updateProduces(with representations: [UserRepresentation]) {
//        
//        // Which representations do we already have in Core Data?
//        let identifiersToFetch = representations.map({ $0.id })
//        
//        // [UUID: UserRepresentation]
//        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
//        
//        // Mutable copy of the dictionary above :
//        
//        // Users that could need to be created OR updated
//        var produceToCreate = representationsByID
//        
//        let context = CoreDataStack.shared.container.newBackgroundContext()
//        
//        context.performAndWait {
//            
//            do {
//                
//                let fetchRequest: NSFetchRequest<Produce> = Produce.fetchRequest()
//                
//                // Only fetch the produceList with the id's that are in this identifiersToFetch array
//                fetchRequest.predicate = NSPredicate(format: "id IN %@", identifiersToFetch)
//                // We need to run the context.fetch on the main queue, because the context is the main context
//                
//                let existingProduceList = try context.fetch(fetchRequest)
//                
//                // Update the ones we do have :
//                
//                // Produce
//                for produce in existingProduceList {
//                    
//                    // Grab the ProduceRepresentations that corresponds to this Produce
//                    guard let id = produce.id,
//                        let representation = representationsByID[id] else { continue }
//                    
//                    produce.name = representation.name
////                    pro.username = representation.username
////                    user.password = representation.password
////                    user.isLoggedIn = representation.isLoggedIn
////                    user.firstName = representation.firstName
////                    user.lastName = representation.lastName
////                    user.phoneNum = representation.phoneNum
////TODO:                    user.userType = representation.userType
//                    
//                    // We just updated a user, we don't need to create a new User for this id
//                    UsersToCreate.removeValue(forKey: id)
//                }
//                
//                // Figure out which ones we don't have
//                
//                // Users that don't exist in Core Data already
//                for representation in UsersToCreate.values {
//                    User(userRepresentation: representation, context: context)
//                }
//                
//                // Persist all the changes (updating and creating) to Core Data
//                CoreDataStack.shared.save(context: context)
//            } catch {
//                NSLog("Error fetching users from persistent store: \(error)")
//            }
//        }
//    }
//    
//    //MARK: PUT Produce Array to Server
//    
//    func put(user: User, produces: [Produce], completion: @escaping () -> Void = { }) {
//        
//        guard let baseURL = controller?.baseURL,
//                let userID = user.id,
//                let produceID = produce.id else { return }
//        
//        
//        let requestURL = baseURL
//            .appendingPathComponent(userID.uuidString)
//            .appendingPathComponent(produceID.uuidString)
//            .appendingPathExtension("json")
//        
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.put.rawValue
//        
//        guard let userRepresentation = user.userRepresentation else {
//            NSLog("User's Representation is nil")
//            completion()
//            return
//        }
//        
//        do {
//            request.httpBody = try JSONEncoder().encode(userRepresentation)
//        } catch {
//            NSLog("Error encoding user representation: \(error)")
//            completion()
//            return
//        }
//        
//        URLSession.shared.dataTask(with: request) { (_, _, error) in
//            
//            if let error = error {
//                NSLog("Error PUTting user: \(error)")
//                completion()
//                return
//            }
//            
//            completion()
//        }.resume()
//    }
//    
//    //MARK: DeleteUserFromServer
//    func deleteUserFromServer(_ user: User, completion: @escaping () -> Void = { }) {
//        
//        guard let id = user.id else {
//            completion()
//            return
//        }
//        
//        let requestURL = baseURL
//            .appendingPathComponent(id.uuidString)
//            .appendingPathExtension("json")
//        
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.delete.rawValue
//        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            
//            if let error = error {
//                NSLog("Error deleting user \(user.firstName ?? "") from server: \(error)")
//                completion()
//                return
//            }
//            
//            completion()
//        }.resume()
//    }
//    
//    //MARK:  CoreData CRUD
//    
//    // Create
//    func createUser(with username: String, password: String, isLoggedIn: Bool, firstName: String, lastName: String, phoneNum: Int16, userType: String, context: NSManagedObjectContext) {
//        
//        let user = User(username: username, password: password, isLoggedIn: isLoggedIn, firstName: firstName, lastName: lastName, phoneNum: phoneNum, userType: userType, context: context)
//        CoreDataStack.shared.save(context: context)
//        put(user: user)
//    }
//    
//    // Update
//    func updateUser(user: User, with firstName: String, lastName: String, phoneNum: Int16, context: NSManagedObjectContext) {
//        
//        user.firstName = firstName
//        user.lastName = lastName
//        user.phoneNum = phoneNum
//        CoreDataStack.shared.save(context: context)
//        put(user: user)
//    }
//    
//    func updateUserType(user: User, isLoggedIn: Bool, context: NSManagedObjectContext) {
//        
//        user.isLoggedIn = isLoggedIn
//        CoreDataStack.shared.save(context: context)
//        put(user: user)
//    }
//    
//    // Delete
//    func deleteUser(user: User, context: NSManagedObjectContext) {
//        
//        context.performAndWait {
//            deleteUserFromServer(user)
//            context.delete(user)
//            CoreDataStack.shared.save(context: context)
//        }
//    }
}
