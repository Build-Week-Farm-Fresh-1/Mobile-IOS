//
//  OrderRepresentation.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct OrderRepresentation {
    
    let id: UUID
    let clientName: String
    let clientPhoneNum: String
    let pickUpDate: Date
    let itemsInCart: [Produce]
}
