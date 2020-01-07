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
    let id: UUID
    let image: String // Might need to change to Data, URL, String or UIImage
    let farmerName: String
    let produceDescription: String
}
