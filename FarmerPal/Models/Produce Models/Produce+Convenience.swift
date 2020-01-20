//
//  Produce+Convenience.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Produce {
    
    // MARK: ProduceRepresentation Setup
    var produceRepresentation: ProduceRepresentation? {
        
        guard let name = name,
//            let plu = plu,
            let increment = increment,
//            let sku = sku,
//            let quantity = quantity,
            let produceImgURL = produceImgURL,
            let produceDescription = produceDescription else { return nil }
//            let price = price
//            let farmerID = farmerID,
        
        return ProduceRepresentation(name: name, plu: plu, increment: increment, sku: sku, quantity: quantity, produceImgURL: produceImgURL, produceDescription: produceDescription, price: price, farmerID: farmerID)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(name: String,
                                        plu: Int16,
                                        increment: String?,
                                        sku: Int16?,
                                        quantity: Int16?,
                                        produceImgURL: String?,
                                        produceDescription: String,
                                        price: Double?,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        guard let quantity = quantity,
            let price = price,
            let sku = sku else { return }
        
        self.name = name
        self.plu = plu
        self.increment = increment
        self.sku = sku
        self.quantity = quantity
        self.produceImgURL = produceImgURL
        self.produceDescription = produceDescription
        self.price = price
    }
    
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(name: String,
                                        plu: Int16,
                                        increment: String?,
//                                        sku: Int16?,
//                                        quantity: Int16?,
                                        produceImgURL: String?,
                                        produceDescription: String,
                                        price: Double?,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.name = name
        self.plu = plu
        self.increment = increment
//        self.sku = sku
//        self.quantity = quantity
        self.produceImgURL = produceImgURL
        self.produceDescription = produceDescription
//        self.price = price
    }
    
    
    
    
    // MARK: Init from Representation
    @discardableResult convenience init?(produceRepresentation: ProduceRepresentation, context: NSManagedObjectContext) {
        
//        guard let sku = "\(produceRepresentation.sku)" ?? nil,
//            let quantity = "\(produceRepresentation.quantity)" ?? nil,
//            let price = "\(produceRepresentation.price)" ?? nil else { return }
        
        self.init(name: produceRepresentation.name,
                  plu: produceRepresentation.plu,
                  increment: produceRepresentation.increment,
                  sku: produceRepresentation.sku,
                  quantity: produceRepresentation.quantity,
                  produceImgURL: produceRepresentation.produceImgURL,
                  produceDescription: produceRepresentation.produceDescription,
                  price: produceRepresentation.price,
                  context: context)
    }
}
