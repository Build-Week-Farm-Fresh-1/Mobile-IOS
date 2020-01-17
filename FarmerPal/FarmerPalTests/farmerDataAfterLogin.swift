//
//  farmerDataAfterLogin.swift
//  FarmerPalTests
//
//  Created by macbook on 1/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

let farmerRepDataAfterLogin =
"""
{
  "user": {
    "id": 125,
    "username": "myFarmer90",
    "city": "dfg",
    "state": "dfg",
    "zipCode": 984,
    "profileImgURL": null,
    "farmImgURL": null
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTI1LCJ1c2VybmFtZSI6Im15RmFybWVyOTAiLCJyb2xlIjoiZmFybWVyIiwiaWF0IjoxNTc5MjE4Nzc5LCJleHAiOjE1Nzk4MjM1Nzl9.--jyD37mnqUqeDbqa1CgAKLa-cBl3gMcgSikXYtbTCE",
  "message": "Welcome back myFarmer90"
}
""".data(using: .utf8)!
