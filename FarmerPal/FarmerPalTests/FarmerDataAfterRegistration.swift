//
//  FarmerDataAfterRegistration.swift
//  FarmerPalTests
//
//  Created by macbook on 1/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

let farmerRepDataAfterRegistration =
    """
    {
      "newFarmer": {
        "id": 126,
        "username": "farmer90190",
        "password": "$2a$10$YBp5aE33qEbZULISneYaYu4sWPqYW5S.3Ddek3A5FgGj5y5n9pV/e",
        "city": "City",
        "state": "Arizona",
        "zipCode": 85282,
        "profileImgURL": null,
        "farmImgURL": null
      },
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTI2LCJ1c2VybmFtZSI6ImZhcm1lcjkwMTkwIiwicm9sZSI6ImZhcm1lciIsImlhdCI6MTU3OTIyODQ3MSwiZXhwIjoxNTc5ODMzMjcxfQ.jQ51We2DJCUCdWPrcnpXJRmUBOEaXv65eO-8KUss0yk",
      "message": "Welcome to the group farmer90190"
    }
    """.data(using: .utf8)!

