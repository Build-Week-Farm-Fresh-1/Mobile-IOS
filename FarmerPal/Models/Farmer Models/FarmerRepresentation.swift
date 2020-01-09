//
//  FarmerRepresentation.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct FarmerRepresentation: Codable {
    let username: String
    let password: String
    let id: UUID
    
    let city: String
    let state: String
    let zipcode: String
    let profileImgURL: String
    let farmImgURL: String
    
    let firstName: String
    let lastName: String
    let phoneNum: Int16
    let email: String
    let userType: UserType
}
