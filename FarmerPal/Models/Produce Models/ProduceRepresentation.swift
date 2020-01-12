//
//  ProduceRepresentation.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct ProduceRepresentation: Codable {
    let name: String
    let plu: Int16
    let increment: String?
    let sku: Int16?
    let quantity: Int16?
    let produceImgURL: String?
    let produceDescription: String
    let price: Int16?
    let farmerID: Int16?
    
    enum CodingKeys: String, CodingKey {
        case name
        case plu = "PLU"
        case increment
        case sku = "SKU"
        case quantity
        case produceImgURL
        case produceDescription = "description"
        case price
        case farmerID = "farmer_id"
    }
}
