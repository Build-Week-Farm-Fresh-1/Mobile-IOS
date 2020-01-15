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
//            let id = id,
            let city = city,
            let state = state,
//            let zipCode = zipCode,
            let farmImgURL = farmImgURL,
            let profileImgURL = profileImgURL,
            let email = email,
            let phoneNum = phoneNum,
            let firstName = firstName,
            let lastName = lastName else { return nil }
        
        return FarmerRepresentation(username: username, password: password, id: id, city: city, state: state, zipCode: zipCode, profileImgURL: profileImgURL, farmImgURL: farmImgURL, email: email, phoneNum: phoneNum, firstName: firstName, lastName: lastName)
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(username: String,
                                        password: String,
                                        id: Int16?,
                                        city: String,
                                        state: String,
                                        zipCode: Int16,
                                        profileImgURL: String?,
                                        farmImgURL: String?,
                                        email: String?,
                                        phoneNum: String?,
                                        firstName: String?,
                                        lastName: String?,
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
        self.farmImgURL = farmImgURL
        self.email = email
        self.phoneNum = phoneNum
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(farmerRepresentation: FarmerRepresentation, context: NSManagedObjectContext) {
        
        self.init(username: farmerRepresentation.username,
                  password: farmerRepresentation.password,
                  id: farmerRepresentation.id,
                  city: farmerRepresentation.city,
                  state: farmerRepresentation.state,
                  zipCode: farmerRepresentation.zipCode,
                  profileImgURL: farmerRepresentation.profileImgURL,
                  farmImgURL: farmerRepresentation.farmImgURL,
                  email: farmerRepresentation.email,
                  phoneNum: farmerRepresentation.phoneNum,
                  firstName: farmerRepresentation.firstName,
                  lastName: farmerRepresentation.firstName,
                  context: context)
    }
}
