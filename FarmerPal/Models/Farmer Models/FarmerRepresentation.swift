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
    var password: String
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
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case id
        case city
        case state
        case zipCode
        case profileImgURL
        case farmImgURL
        case email
        case phoneNum
        case firstName
        case lastName
    }
}
