//
//  APIController.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

class APIController {
    
    private let baseUrl = URL(string: "https://farmers-fresh-api.herokuapp.com/api")!
    
    var bearer: Bearer?
    var farmer: Farmer?
    var consumer: Consumer?
    var username: String?
    var produceOptionsForFarmer: [ProduceRepresentation]?
    
    // MARK: Register Functions
    
    // Register Farmer
    func registerFarmer(username: String, password: String, city: String, state: String, zipCode: String, email: String, firstName: String, lastName: String, phoneNum: String, completion: @escaping (Error?) -> ()) {
        
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
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                DispatchQueue.main.async {
                    let statusCodeError = NSError(domain: "com.FarmPal", code: response.statusCode, userInfo: nil)
                    completion(statusCodeError)
                    
                }
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
            } catch {
                NSLog("Error decoding farmer bearer: \(error)")

                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    // Register Consumer
    func registerConsumer(username: String, password: String, city: String, state: String, zipCode: String, email: String, firstName: String, lastName: String, phoneNum: String, completion: @escaping (Error?) -> ()) {
        
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
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                DispatchQueue.main.async {
                    let statusCodeError = NSError(domain: "com.FarmPal", code: response.statusCode, userInfo: nil)
                    completion(statusCodeError)
                    
                }
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
            } catch {
                NSLog("Error decoding farmer bearer: \(error)")

                completion(error)
                return
            }
            completion(nil)
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
        print(request)
        
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
                
//                guard let farmer = self.farmer else { return }
                
//                let farmerRepresentation = try JSONDecoder().decode(FarmerRepresentation.self, from: data)
//                try self.updateFarmer(with: farmerRepresentation)
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
            print(request)
            
    //        do {
    //            request.httpBody = try JSONEncoder().encode(farmer.farmerRepresentation)
    //        } catch {
    //            NSLog("Error encoding farmer for login: \(error)")
    //            completion(error)
    //        }
            
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
                    
    //                guard let consumer = self.consumer else { return }
                    
    //                let consumerRepresentation = try JSONDecoder().decode(FarmerRepresentation.self, from: data)
    //                try self.updateConsumer(with: farmerRepresentation)
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
        
        let possibleFarmers = try? moc.fetch(fetchRequest)
        
        guard let farmers = possibleFarmers else { return nil }
        for farmer in farmers {
            
            if farmer.username == self.username {
                self.farmer = farmer
                return farmer
            } else {
                print("Couldn't fetch farmer from CoreData")
                return nil
            }
            
//            moc.delete(user)
//            try? CoreDataStack.shared.save(context: moc)
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
                
    //            moc.delete(user)
    //            try? CoreDataStack.shared.save(context: moc)
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
//        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)

        
        //MARK: DataTask
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching produce options for farmer: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let produceOptions = try JSONDecoder().decode([ProduceRepresentation].self, from: data)
                self.produceOptionsForFarmer = produceOptions
                
//                let produceOptions = try JSONDecoder().decode([String: ProduceRepresentation].self, from: data).map({ $0.value })
//
//                // Figure out the options that need to be created, and the ones that need to be updated
//                self.updateProduceOptions(with: produceOptions)
                // TODO: Not sure if I need to update produceOptions here or not, cause I can't create new options
                completion(.success(produceOptions))
            } catch {
                NSLog("Error decoding produce options for farmer: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    //MARK: UpdateProduceList
    func updateProduceOptions(with representations: [ProduceRepresentation]) {
        
//        // Which representations do we already have in Core Data?
//        
//        let identifiersToFetch = representations.map({ String($0.plu) })
//        
//        // [UUID: ProduceRepresentation]
//        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
//        
//        // Make a mutable copy of the dictionary above
//        
//        // produce that could need to be created OR updated
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
//                // Only fetch the produce with the plu's that are in this identifiersToFetch array
//                fetchRequest.predicate = NSPredicate(format: "plu IN %@", identifiersToFetch)
//                // We need to run the context.fetch on the main queue, because the context is the main context
//                
//                let existingProduceOptions = try context.fetch(fetchRequest)
//                
//                // Update the ones we do have
//                
//                // Produce
//                for produce in existingProduceOptions {
//                    
//                    // Grab the ProduceRepresentation that corresponds to this Produce
//                    guard let plu = produce.plu,
//                        let representation = representationsByID[plu] else { continue }
//                    
////                    produce.name = representation.name
////                    produce.quantity = representation.quantity
////                    produce.produceImgURL = representation.produceImgURL
////                    produce.produceDescription = representation.produceDescription
////                    produce.sku = representation.sku
////                    produce.increment = representation.increment
//                    
//                    // We just updated a produce, we don't need to create a new Produce for this plu
//                    produceToCreate.removeValue(forKey: plu)
//                }
//                
//                // Figure out which ones we don't have
//                
//                // produce that don't exist in Core Data already
//                for representation in produceToCreate.values {
//                    Produce(produceRepresentation: representation, context: context)
//                }
//                
//                // Persist all the changes (updating and creating of produce) to Core Data
//                CoreDataStack.shared.save(context: context)
//            } catch {
//                NSLog("Error fetching produceOptions from persistent store: \(error)")
//            }
//        }
    }
    
    
    
    // Add New Produce
    func addNewProduce(name: String, productDescription: String, completion: @escaping (Result<ProduceRepresentation, NetworkingError>) -> Void) {
        
        guard let bearer = bearer else {
            completion(Result.failure(NetworkingError.noBearer))
            return
        }
        
        let randomNum = Int.random(in:0...10000)
        
        let requestURL = baseUrl
            .appendingPathComponent("produce")
        
        let json = """
        {
        "PLU": "\(randomNum)",
        "name": "\(name)",
        "description": "\(productDescription)"
        }
        """
        
        let jsonData = json.data(using: .utf8)
        
        guard let unwrapped = jsonData else {
            print("No data!")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        request.httpBody = unwrapped
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error adding new produce to server: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Status code: \(response.statusCode)")
                print("\(response.self)")
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let produceRepresentation = try JSONDecoder().decode(ProduceRepresentation.self, from: data)
                self.createNewProduce(produceRepresentation: produceRepresentation, context: CoreDataStack.shared.mainContext)
                
                completion(.success(produceRepresentation))
            } catch {
                NSLog("Error decoding produceRep: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    
    
    //MARK:  CoreData CRUD
    
    // Create:
    
    // Farmer
    func createFarmer(username: String, password: String, id: String, city: String, state: String, zipCode: String, profileImgURL: String?, farmImgURL: String?, context: NSManagedObjectContext) {
        
        self.farmer = Farmer(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL, farmImgURL: farmImgURL, context: context)
        CoreDataStack.shared.save(context: context)
        //        put(user: user)
    }
    
    // Consumer
    func createConsumer(username: String, password: String, id: String, city: String, state: String, zipCode: String, profileImgURL: String?, context: NSManagedObjectContext) {
        
        self.consumer = Consumer(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL, context: context)
        CoreDataStack.shared.save(context: context)
        //        put(user: user)
    }
    
    // Produce
    func createNewProduce(produceRepresentation: ProduceRepresentation, context: NSManagedObjectContext) {
        
        let produce = Produce(produceRepresentation: produceRepresentation, context: context)
        CoreDataStack.shared.save(context: context)
    }
    // Update:
    
    // Farmer
    private func updateFarmer(with representation: FarmerRepresentation) {
        
//        farmer.username = representation.username
//        farmer.password = representation.password
//        farmer.id = representation.id
//        farmer.city = representation.city
//        farmer.state = representation.state
//        farmer.zipCode = representation.zipCode
//        farmer.firstName = representation.firstName
//        farmer.lastName = representation.lastName
//        farmer.phoneNum = representation.phoneNum
//        farmer.farmImgURL = representation.farmImgURL
//        farmer.profileImgURL = representation.profileImgURL
//        farmer.email = representation.email
    }
}
