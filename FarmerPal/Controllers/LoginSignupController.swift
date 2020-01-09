//
//  LoginSignupController.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class LoginSignupController {
//    
//    private let baseUrl = URL(string: "https://lambdaanimalspotter.vapor.cloud/api")!
//    
//    var bearer: Bearer?
//    
//    
//    // MARK: Sign up Function
//    
//    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
//        
//        // Build URL
//        let requestURL = baseUrl
//            .appendingPathComponent("users")
//            .appendingPathComponent("signup")
//        
//        // Build the request
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//        
//        // Tell the API that the body is in JSON format
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
//        // MARK: DataTask  Performing the request
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            // Handle errors
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
//            // nil means there was no error, everthing succeeded.
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
//        // MARK: DataTask
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
//    
}
