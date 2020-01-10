//
//  ConsumerRepresentation.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ConsumerRepresentation: Codable {
    let username: String
    let password: String
    let id: String
    
    let city: String
    let state: String
    let zipCode: String
    let profileImgURL: String
}
