//
//  ConsumerRepresentation.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ConsumerRepresentation: Codable {
    var username: String
    var password: String
    var id: Int16?
    
    var city: String
    var state: String
    var zipCode: Int16
    var profileImgURL: String?
    
    var email: String?
    var phoneNum: String?
    var firstName: String?
    var lastName: String?
}
