//
//  APIController.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class APIController {
    
    private let baseUrl = URL(string: "https://farmers-fresh-api.herokuapp.com/api")!
    
    var bearer: Bearer?
    var farmer: Farmer?
    var consumer: Consumer?
    var username: String?
    var produceOptionsForFarmer: [ProduceRepresentation]?
    var produce: Produce?
    var produceRep: ProduceRepresentation?
    
    var produceQuantity: Int16?
    var producePrice: Double?
    
    // MARK: Register Functions
    
    // Register Farmer
    func registerFarmer(username: String, password: String, city: String, state: String, zipCode: String, email: String, firstName: String, lastName: String, phoneNum: String, completion: @escaping (Result<FarmerRepresentation, NetworkingError>) -> Void) {
        
        let requestURL = baseUrl
            .appendingPathComponent("farmers")
            .appendingPathComponent("register")
        
        let json = """
        {
        "username": "\(username)",
        "password": "\(password)",
        "city": "\(city)",
        "state": "\(state)",
        "zipCode": "\(zipCode)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            print("No data!")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = unwrapped
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                
                DispatchQueue.main.async {
                    print("Status code: \(response.statusCode)")
                    print("All header fields: \(response.allHeaderFields)")
                    print("Self: \(response.self)")
                    completion(.failure(.unexpectedStatusCode(response.statusCode)))
                }
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                print("\(data)")
                let farmerRep = try JSONDecoder().decode(FarmerRepresentation.self, from: data)
                
                //create New Farmer, save it as self.farmer, and save it in CD
                self.createFarmer(farmerRepresentation: farmerRep, firstName: firstName, lastName: lastName, phoneNum: phoneNum, email: email, context: CoreDataStack.shared.mainContext)
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
                completion(.success(farmerRep))
            } catch {
                completion(Result.failure(NetworkingError.badDecode))
                return
            }
        }.resume()
    }
    
    // Register Consumer
    func registerConsumer(username: String, password: String, city: String, state: String, zipCode: String, email: String, firstName: String, lastName: String, phoneNum: String, completion: @escaping (Result<ConsumerRepresentation, NetworkingError>) -> Void) {
        
        let requestURL = baseUrl
            .appendingPathComponent("users")
            .appendingPathComponent("register")
        
        let json = """
        {
        "username": "\(username)",
        "password": "\(password)",
        "city": "\(city)",
        "state": "\(state)",
        "zipCode": "\(zipCode)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            print("No data!")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = unwrapped
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(Result.failure(NetworkingError.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(.failure(.unexpectedStatusCode(response.statusCode)))
                }
            }
            
            guard let data = data else {
                completion(Result.failure(NetworkingError.noData))
                return
            }
            
            do {
                let consumerRep = try JSONDecoder().decode(ConsumerRepresentation.self, from: data)
                self.createConsumer(consumerRepresentation: consumerRep, context: CoreDataStack.shared.mainContext)
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
                completion(.success(consumerRep))
            } catch {
                NSLog("Error decoding consumer, or bearer: \(error)")
                completion(.failure(.badDecode))
                return
            }
            completion(.failure(.unexpectedError))
        }.resume()
    }
    
    // MARK: Login Functions
    
    // Login Farmer
    func loginFarmer(username: String, password: String, completion: @escaping (Error?) -> ()) {
        
        let requestURL = baseUrl
            .appendingPathComponent("farmers")
            .appendingPathComponent("login")
        
        let json = """
        {
        "username": "\(username)",
        "password": "\(password)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            print("No data!")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = unwrapped
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error login in farmer: \(error)")
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Wrong response: \(response.statusCode)")
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                
                let farmerRepresentation = try JSONDecoder().decode(FarmerRepresentation.self, from: data)
                self.updateFarmer(with: farmerRepresentation)
                self.username = username
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
                completion(nil)
            } catch {
                NSLog("Error decoding the bearer: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    // Login Consumer
    func loginConsumer(username: String, password: String, completion: @escaping (Error?) -> ()) {
        
        let requestURL = baseUrl
            .appendingPathComponent("users")
            .appendingPathComponent("login")
        
        let json = """
        {
        "username": "\(username)",
        "password": "\(password)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            print("No data!")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = unwrapped
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error login in consumer: \(error)")
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print(response.statusCode)
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                self.username = username
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
            } catch {
                NSLog("Error decoding the bearer: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    // MARK: Fetching Users from CoreData
    
    func fetchFarmerFromCD(with username: String) -> Farmer? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Farmer> = Farmer.fetchRequest()
        let myArray = [username]
        fetchRequest.predicate = NSPredicate(format: "username IN %@", myArray)
        
        let possibleFarmers = try? moc.fetch(fetchRequest)
        
        guard let farmers = possibleFarmers else { return nil }
        for farmer in farmers {
            
            if farmer.username == username {
                self.farmer = farmer
            } else {
                print("Couldn't fetch farmer from CoreData")
            }
        }
        return farmer
    }
    
    func fetchConsumerFromCD(with username: String) -> Consumer? {
        
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<Consumer> = Consumer.fetchRequest()
        
        let possibleConsumers = try? moc.fetch(fetchRequest)
        
        guard let consumers = possibleConsumers else { return nil }
        for consumer in consumers {
            
            if consumer.username == self.username {
                self.consumer = consumer
                return consumer
            } else {
                print("Couldn't fetch consumer from CoreData")
                return nil
            }
        }
        return consumer
    }
    
    // MARK: Fetching Farmer's Produce Options
    
    // The Result enum has -> [String] for its success, and a NetworkingError for its failure.
    func fetchProduceOptionsForFarmer(completion: @escaping (Result<[ProduceRepresentation], NetworkingError>) -> Void) {
        
        guard let bearer = bearer else {
            completion(Result.failure(NetworkingError.noBearer))
            return
        }
        
        let requestURL = baseUrl
            .appendingPathComponent("produce")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        request.setValue("\(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
       
        //MARK: DataTask
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching produce options for farmer: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let produceOptions = try JSONDecoder().decode([ProduceRepresentation].self, from: data)
                self.produceOptionsForFarmer = produceOptions
                completion(.success(produceOptions))
            } catch {
                NSLog("Error decoding produce options for farmer: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    // Add a Produce to Farmer's Inventory
    func addProduceToFarmerInventory(produce: ProduceRepresentation, farmer: Farmer, quantity: Int16, increment: String = "lb", price: Double, completion: @escaping (Result<ProduceRepresentation, NetworkingError>) -> Void) {
        
        guard let bearer = bearer else {
            completion(Result.failure(NetworkingError.noBearer))
            return
        }

        let requestURL = baseUrl
            .appendingPathComponent("farmers")
            .appendingPathComponent("\(farmer.id)")
            .appendingPathComponent("inventory")
        
        let randomNum = Int.random(in: 100..<2000)
        
        let json = """
        {
        "SKU": "\(randomNum)",
        "PLU": "\(produce.plu)",
        "quantity": "\(quantity)",
        "increment": "\(increment)",
        "price": "\(price)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            completion(Result.failure(NetworkingError.noData))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = unwrapped
        request.setValue("\(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
        print(request)
        print("URL Session is about to run")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(Result.failure(NetworkingError.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(Result.failure(NetworkingError.unexpectedStatusCode(response.statusCode)))
                }
            }
            
            guard let data = data else {
                completion(Result.failure(NetworkingError.noData))
                return
            }
            
            do {
                
                let produceRep = try JSONDecoder().decode(ProduceRepresentation.self, from: data)
                self.produceRep = produceRep
                self.putNewProduceInFarmerInventory(produceRepresentation: produceRep, context: CoreDataStack.shared.mainContext)
                
                completion(Result.success(produceRep))
            } catch {
                completion(Result.failure(NetworkingError.badDecode))
                return
            }
        }.resume()
    }
    
    //MARK: UpdateProduceList
    func updateProduceOptions(with representations: [ProduceRepresentation]) {

    }
    
    // MARK:  CoreData CRUD
    
    // Create:
    
    // Farmer
    func createFarmer(farmerRepresentation: FarmerRepresentation, firstName: String, lastName: String, phoneNum: String, email: String, context: NSManagedObjectContext) {
        
        self.farmer = Farmer(username: farmerRepresentation.username,
                             password: farmerRepresentation.password,
                             id: farmerRepresentation.id,
                             city: farmerRepresentation.city,
                             state: farmerRepresentation.state,
                             zipCode: farmerRepresentation.zipCode,
                             profileImgURL: farmerRepresentation.profileImgURL,
                             farmImgURL: farmerRepresentation.farmImgURL,
                             email: email,
                             phoneNum: phoneNum,
                             firstName: firstName,
                             lastName: lastName,
                             context: context)
        CoreDataStack.shared.save(context: context)
    }
    
    // Consumer
    func createConsumer(consumerRepresentation: ConsumerRepresentation, context: NSManagedObjectContext) {
        
        self.consumer = Consumer(username: consumerRepresentation.username,
                                 password: consumerRepresentation.password,
                                 id: consumerRepresentation.id,
                                 city: consumerRepresentation.city,
                                 state: consumerRepresentation.state,
                                 zipCode: consumerRepresentation.zipCode,
                                 profileImgURL: consumerRepresentation.profileImgURL, context: context)
        CoreDataStack.shared.save(context: context)
    }
    
    // Produce
    private func putNewProduceInFarmerInventory(produceRepresentation: ProduceRepresentation, context: NSManagedObjectContext) {
        
        let produce = Produce(produceRepresentation: produceRepresentation, context: context)
        CoreDataStack.shared.save(context: context)
    }
    
    // Update:
    
    // Produce
    private func updateProduceWithProcuRep(produce: Produce, produceRep: ProduceRepresentation) {
        
    }
    
    // Farmer
    private func updateFarmer(with representation: FarmerRepresentation) {
        
        guard let farmer = farmer,
            let id = representation.id  else { return }
        
        farmer.username = representation.username
        farmer.password = representation.password
        farmer.id = id
        farmer.city = representation.city
        farmer.state = representation.state
        farmer.zipCode = representation.zipCode
        farmer.firstName = representation.firstName
        farmer.lastName = representation.lastName
        farmer.phoneNum = representation.phoneNum
        farmer.farmImgURL = representation.farmImgURL
        farmer.profileImgURL = representation.profileImgURL
        farmer.email = representation.email
    }
}
