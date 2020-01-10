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
    
    // MARK: Register Function
    
//    func registerFarmer(farmer: Farmer, completion: @escaping (Error?) -> Void) {
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
                
//                var farmerRepresentation = try JSONDecoder().decode(FarmerRepresentation.self, from: data)
//
//                farmerRepresentation.id =
//                farmerRepresentation.username = username
//                farmerRepresentation.password = password
//                farmerRepresentation.city = city
//                farmerRepresentation.state = state
//                farmerRepresentation.zipCode = zipCode
//                farmerRepresentation.email = email
//                farmerRepresentation.phoneNum = phoneNum
//                farmerRepresentation.state = state
//                farmerRepresentation.state = state
//                farmerRepresentation.state = state
//                farmerRepresentation.state = state
            
//                self.farmer = Farmer(farmerRepresentation: farmerRepresentation, context: CoreDataStack.shared.mainContext)
//                try? CoreDataStack.shared.mainContext.save()
                
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
            } catch {
                NSLog("Error decoding farmer bearer: \(error)")
//                NSLog("Error decoding farmer object, or bearer: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
        
        
        
//        // Build the request
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//
//        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
        
        //        let encoder = JSONEncoder()
        //
        //        do {
        //            let farmerJSON = try encoder.encode(farmer)
        //            request.httpBody = farmerJSON
        //        } catch {
        //            NSLog("Error encoding farmer object: \(error)")
        //        }
        //
        //
//        guard let farmerRepresentation = farmer.farmerRepresentation else {
//            NSLog("Farmer's Representation is nil")
//            return
//        }
//
//        do {
//            request.httpBody = try JSONEncoder().encode(farmerRepresentation)
//        } catch {
//            NSLog("Error encoding farmer representation: \(error)")
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                NSLog("Error signing up farmer: \(error)")
//                completion(error)
//            }
//
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//
//                let statusCodeError = NSError(domain: "com.herokuapp.farmers-fresh-api", code: response.statusCode, userInfo: nil)
//                completion(statusCodeError)
//            }
//
//            completion(nil)
//        }.resume()
    }
    
    
//    func registerUser(with username: String, password: String, email: String, completion: @escaping (Error?) -> ()) {
//        
//        let loginUrl = baseUrl.appendingPathComponent("auth/register/")
//        let json = """
//        {
//        "username": "\(username)",
//        "password": "\(password)",
//        "email": "\(email)"
//        }
//        """
//        
//        let jsonData = json.data(using: .utf8)
//        
//        guard let unwrapped = jsonData else {
//            print("No data!")
//            return
//        }
//        
//        var request = URLRequest(url: loginUrl)
//        request.httpMethod = HTTPMethod.post.rawValue
//        
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = unwrapped
//        print(request)
//        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            
//            if let error = error {
//                completion(error)
//                return
//            }
//            
//            guard let data = data else {
//                completion(NSError())
//                return
//            }
//            
//            do {
//                
//                var userRepresentation = try JSONDecoder().decode(UserRepresentation.self, from: data)
//                
//                userRepresentation.email = email
//                userRepresentation.password = password
//                userRepresentation.isAdmin = false
//                
//                self.user = User(userRepresentation: userRepresentation, context: CoreDataStack.shared.mainContext)
//                try? CoreDataStack.shared.mainContext.save()
//            } catch {
//                print("Error decoding user object: \(error)")
//                completion(error)
//                return
//            }
//            completion(nil)
//        }.resume()
//    }
    
    
    
//    // MARK: Sign in Function
//    
//    func signIn(with user: User, completion: @escaping (Error?) -> Void) {
//        
//        let requestURL = baseUrl
//            .appendingPathComponent("users")
//            .appendingPathComponent("login")
//        
//        var request = URLRequest(url: requestURL)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = HTTPMethod.post.rawValue
//        
//        do {
//            request.httpBody = try JSONEncoder().encode(user)
//        } catch {
//            NSLog("Error encoding user for sign in: \(error)")
//            completion(error)
//        }
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let error = error {
//                NSLog("Error signing in user: \(error)")
//                completion(error)
//                return
//            }
//            
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                
//                let statusCodeError = NSError(domain: "com.SpencerCurtis.AnimalSpotter", code: response.statusCode, userInfo: nil)
//                completion(statusCodeError)
//            }
//            
//            guard let data = data else {
//                NSLog("No data returned from data task")
//                let noDataError = NSError(domain: "com.SpencerCurtis.AnimalSpotter", code: -1, userInfo: nil)
//                completion(noDataError)
//                return
//            }
//            
//            do {
//                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
//                self.bearer = bearer
//            } catch {
//                NSLog("Error decoding the bearer token: \(error)")
//                completion(error)
//            }
//            
//            completion(nil)
//        }.resume()
//    }
    
    
    
        //MARK:  CoreData CRUD
        
        // Create
        func createFarmer(username: String, password: String, id: String, city: String, state: String, zipCode: String, profileImgURL: String?, farmImgURL: String?, context: NSManagedObjectContext) {
            
            
//            DispatchQueue.main.async {
                self.farmer = Farmer(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL, farmImgURL: farmImgURL, context: context)
                CoreDataStack.shared.save(context: context)
//            }
    //        put(user: user)
        }
}
