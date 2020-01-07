//
//  User+Convenience.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    // MARK: UserRepresentation Setup
    var userRepresentation: UserRepresentation? {
        
        guard let username = username,
            let password = password,
            let id = id,
            let firstName = firstName,
            let lastName = lastName,
            let email = email,
            let type = userType else { return nil }
        
        var newUserType: UserType = UserType.consumer
        
        switch type {
        case UserType.farmer.rawValue :
            newUserType = UserType.farmer
        case UserType.consumer.rawValue :
            newUserType = UserType.consumer
        default:
            break
        }
        
        return UserRepresentation(username: username, password: password, id: id, isLoggedIn: isLoggedIn, firstName: firstName, lastName: lastName, phoneNum: phoneNum, email: email, userType: newUserType)
        
    }
    
    // MARK: CoreData Initializer
    @discardableResult convenience init(username: String,
                                        password: String,
                                        id: UUID = UUID(),  //Setting up an id from it's CD Creation
                                        isLoggedIn: Bool,
                                        firstName: String,
                                        lastName: String,
                                        phoneNum: Int16,
                                        email: String,
                                        userType: String,
                                        context: NSManagedObjectContext) {
        
        self.init(context: context)
        
        self.username = username
        self.password = password
        self.id = id
        self.isLoggedIn = isLoggedIn
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNum = phoneNum
        self.email = email
        self.userType = userType
    }
    
    // MARK: Init from Representation
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext) {
        
//        guard let id =
        
        self.init(username: userRepresentation.username,
                  password: userRepresentation.password,
                  id: userRepresentation.id,
                  isLoggedIn: userRepresentation.isLoggedIn,
                  firstName: userRepresentation.firstName,
                  lastName: userRepresentation.lastName,
                  phoneNum: userRepresentation.phoneNum,
                  email: userRepresentation.email,
                  userType: userRepresentation.userType.rawValue,
                  context: context)
    }
}
