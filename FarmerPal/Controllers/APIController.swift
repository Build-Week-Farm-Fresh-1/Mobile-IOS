//
//  APIController.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class APIController {
    
    private let baseUrl = URL(string: "https://farmers-fresh-api.herokuapp.com/api")!
    
    var bearer: Bearer?
    
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
//    
//    // MARK: Sign up Function
//    
//    func registerFarmer(farmer: Farmer, completion: @escaping (Error?) -> Void) {
//        
//        // Build URL
//        let requestURL = baseUrl
//            .appendingPathComponent("farmers")
//            .appendingPathComponent("register")
//        
//        // Build the request
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//        
//        request.setValue("application/json", forHTTPHeaderField: HeaderNames.contentType.rawValue)
//        
//        let encoder = JSONEncoder()
//        
//        do {
//            let userJSON = try encoder.encode(user)
//            request.httpBody = userJSON
//        } catch {
//            NSLog("Error encoding user object: \(error)")
//        }
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if let error = error {
//                NSLog("Error signing up user: \(error)")
//                completion(error)
//            }
//            
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                
//                let statusCodeError = NSError(domain: "com.SpencerCurtis.AnimalSpotter", code: response.statusCode, userInfo: nil)
//                completion(statusCodeError)
//            }
//            
//            completion(nil)
//        }.resume()
//    }
//    
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
}
