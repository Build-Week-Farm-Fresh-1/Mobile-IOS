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
        
//        do {
//            request.httpBody = try JSONEncoder().encode(farmer.farmerRepresentation)
//        } catch {
//            NSLog("Error encoding farmer for login: \(error)")
//            completion(error)
//        }
        
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


//    // MARK: Function for fetching all
//
//    // An [String] for its success, and a NetworkingError for its failure.
//    func fetchAllAnimalNames(completion: @escaping (Result<[String], NetworkingError>) -> Void) {
//
//        guard let bearer = bearer else {
//            completion(Result.failure(NetworkingError.noBearer))
//            return
//        }
//
//        let requestURL = baseUrl
//            .appendingPathComponent("animals")  // endpoint
//            .appendingPathComponent("all")      //endpoint  (to get array of all animals)
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//
//        // "Bearer fsMd9aHpoJ62vo4OvLC79MDqd38oE2ihkx6A1KeFwek"
//        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
//
//        //MARK: DataTask
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                NSLog("Error fetching animal names: \(error)")
//                completion(.failure(.serverError(error)))
//                return
//            }
//
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                completion(.failure(.unexpectedStatusCode))
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            do {
//                let animalNames = try JSONDecoder().decode([String].self, from: data)
//
//                completion(.success(animalNames))
//            } catch {
//                NSLog("Error decoding animal names: \(error)")
//                completion(.failure(.badDecode))
//            }
//        }.resume()
//    }
//
//    // MARK: Function to fetch specific animal
//
//    func fetchDetails(for animalName: String, completion: @escaping (Result<Animal, NetworkingError>) -> Void) {
//
//        guard let bearer = bearer else {
//            completion(.failure(.noBearer))
//            return
//        }
//
//        let requestURL = baseUrl
//            .appendingPathComponent("animals")
//            .appendingPathComponent(animalName)
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: HeaderNames.authorization.rawValue)
//
//        // MARK: DataTask
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                NSLog("Error fetching animal details: \(error)")
//                completion(.failure(.serverError(error)))
//            }
//
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                completion(.failure(.unexpectedStatusCode))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .secondsSince1970
//
//                let animal = try decoder.decode(Animal.self, from: data)
//
//                completion(.success(animal))
//
//            } catch {
//                NSLog("Error decoding Animal: \(error)")
//                completion(.failure(.badDecode))
//            }
//        }.resume()
//    }
//
//    // MARK: Fetch image Function
//
//    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
//
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        //MARK DataTask
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//
//            if let error = error {
//                NSLog("Error fetching image: \(error)")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data returned from image fetch data task")
//                completion(nil)
//                return
//            }
//
//            let image = UIImage(data: data)
//
//            completion(image)
//
//        }.resume()
//    }
