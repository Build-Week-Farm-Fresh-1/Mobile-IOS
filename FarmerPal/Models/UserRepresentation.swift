//
//  UserRepresentation.swift
//  FarmFreshDemo
//
//  Created by macbook on 1/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable {
    let username: String
    let password: String
    let id: UUID
    let isLoggedIn: Bool
    let firstName: String
    let lastName: String
    let phoneNum: Int16
    let email: String
    let userType: UserType
}
