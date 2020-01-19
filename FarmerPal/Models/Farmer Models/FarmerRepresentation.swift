//
//  FarmerRepresentation.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct FarmerRepresentation: Codable {
    var username: String
    var password: String?
    var id: Int16?
    
    var city: String
    var state: String
    var zipCode: Int16
    var profileImgURL: String?
    var farmImgURL: String?
    
    var email: String?
    var phoneNum: String?
    var firstName: String?
    var lastName: String?
    
    enum FarmerCodingKeys: String, CodingKey {
//        case email
//        case phoneNum
//        case firstName
//        case lastName
        case user
        case newFarmer
        
        enum NewFarmerCodingKeys: String, CodingKey {
            case username
            case password
            case id
            case city
            case state
            case zipCode
            case profileImgURL
            case farmImgURL
        }
        enum UserCodingKeys: String, CodingKey {
            case username
//            case password
            case id
            case city
            case state
            case zipCode
            case profileImgURL
            case farmImgURL
        }
    }
    
    init(username: String, password: String?, id: Int16?, city: String, state: String, zipCode: Int16, profileImgURL: String?, farmImgURL: String?, email: String?, phoneNum: String?, firstName: String?, lastName: String?) {
        
        self.username = username
        self.password = password
        self.id = id
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.profileImgURL = profileImgURL
        self.farmImgURL = farmImgURL
        self.email = email
        self.phoneNum = phoneNum
        self.firstName = firstName
        self.lastName = lastName
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: FarmerCodingKeys.self)
        let newFarmer = try container.nestedContainer(keyedBy: FarmerCodingKeys.NewFarmerCodingKeys.self, forKey: .newFarmer)

            self.id = try newFarmer.decode(Int16.self, forKey: .id)
            self.username = try newFarmer.decode(String.self, forKey: .username)
            self.city = try newFarmer.decode(String.self, forKey: .city)
            self.state = try newFarmer.decode(String.self, forKey: .state)
            self.zipCode = try newFarmer.decode(Int16.self, forKey: .zipCode)
        
//        if let user = try container.nestedContainer(keyedBy: FarmerCodingKeys.UserCodingKeys.self, forKey: .user)
//        self.password = try newFarmer.decode(String.self, forKey: .password)
        
    }
}
