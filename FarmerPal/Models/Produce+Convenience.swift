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
            let id = id,
            let image = image,
            let farmerName = farmerName,
            let produceDescription = produceDescription else { return nil }
        
        return ProduceRepresentation(name: name, id: id, image: image, farmerName: farmerName, produceDescription: produceDescription)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(name: String,
                                        id: UUID = UUID(),  //Setting up an id from it's CD Creation
                                        image: String,
                                        farmerName: String,
                                        produceDescription: String,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.name = name
        self.id = id
        self.image = image
        self.farmerName = farmerName
        self.produceDescription = produceDescription
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(produceRepresentation: ProduceRepresentation, context: NSManagedObjectContext) {
        
//        guard let id == produceRepresentation.id else { return }
        
        self.init(name: produceRepresentation.name,
                  id: produceRepresentation.id,
                  image: produceRepresentation.image,
                  farmerName: produceRepresentation.farmerName,
                  produceDescription: produceRepresentation.produceDescription,
                  context: context)
    }
}
