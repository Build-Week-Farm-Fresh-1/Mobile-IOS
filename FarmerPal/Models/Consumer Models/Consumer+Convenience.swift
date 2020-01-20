//
//  Consumer+Convenience.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Consumer {
    

    // Setup consumerRepresentation
    var consumerRepresentation: ConsumerRepresentation? {
        
        guard let username = username,
            let password = password,
//            let id = id,
            let city = city,
            let state = state,
//            let zipCode = zipCode,
            let profileImgURL = profileImgURL else { return nil }
        
        return ConsumerRepresentation(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(username: String,
                                        password: String,
                                        id: Int16?,
                                        city: String,
                                        state: String,
                                        zipCode: Int16,
                                        profileImgURL: String?,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        guard let id = id else { return }
        
        self.username = username
        self.password = password
        self.id = id
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.profileImgURL = profileImgURL
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(consumerRepresentation: ConsumerRepresentation, context: NSManagedObjectContext) {
        
        self.init(username: consumerRepresentation.username,
                  password: consumerRepresentation.password,
                  id: consumerRepresentation.id,
                  city: consumerRepresentation.city,
                  state: consumerRepresentation.state,
                  zipCode: consumerRepresentation.zipCode,
                  profileImgURL: consumerRepresentation.profileImgURL,
                  context: context)
    }
}
