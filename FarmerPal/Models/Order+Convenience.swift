//
//  Order+Convenience.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Order {
    
    // MARK: OrderRepresentation Setup
    var orderRepresentation: OrderRepresentation? {
        
        guard let id = id,
            let clientName = clientName,
            let clientPhoneNum = clientPhoneNum,
            let pickUpDate = pickUpDate else { return nil }
        
        return OrderRepresentation(id: id, clientName: clientName, clientPhoneNum: clientPhoneNum, pickUpDate: pickUpDate, itemsInCart: [])
        
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(id: UUID = UUID(),  //Setting up an id from it's CD Creation
                                        clientName: String,
                                        clientPhoneNum: String,
                                        pickUpDate: Date,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.id = id
        self.clientName = clientName
        self.clientPhoneNum = clientPhoneNum
        self.pickUpDate = pickUpDate
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(orderRepresentation: OrderRepresentation, context: NSManagedObjectContext) {
        
//        guard let id =
        
        self.init(id: orderRepresentation.id,
                  clientName: orderRepresentation.clientName,
                  clientPhoneNum: orderRepresentation.clientPhoneNum,
                  pickUpDate: orderRepresentation.pickUpDate,
                  context: context)
    }
}
