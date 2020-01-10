//
//  Farmer+Convenience.swift
//  FarmerPal
//
//  Created by macbook on 1/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension Farmer {
    
    // MARK: UserRepresentation Setup
    var farmerRepresentation: FarmerRepresentation? {
        
        guard let username = username,
            let password = password,
            let id = id,
            let city = city,
            let state = state,
            let zipCode = zipCode,
            let farmImgURL = farmImgURL,
            let profileImgURL = profileImgURL else { return nil }
        
        return FarmerRepresentation(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL, farmImgURL: farmImgURL)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(username: String,
                                        password: String,
                                        id: String,
                                        city: String,
                                        state: String,
                                        zipCode: String,
                                        profileImgURL: String?,
                                        farmImgURL: String?,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.username = username
        self.password = password
        self.id = id
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.profileImgURL = profileImgURL
        self.farmImgURL = farmImgURL
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(farmerRepresentation: FarmerRepresentation, context: NSManagedObjectContext) {
        
//        guard let profileImgURL = profileImgURL,
//            let farmImgURL = farmImgURL else { continue }
        
        self.init(username: farmerRepresentation.username,
                  password: farmerRepresentation.password,
                  id: farmerRepresentation.id,
                  city: farmerRepresentation.city,
                  state: farmerRepresentation.state,
                  zipCode: farmerRepresentation.zipCode,
                  profileImgURL: farmerRepresentation.profileImgURL,
                  farmImgURL: farmerRepresentation.farmImgURL,
                  context: context)
    }
}
