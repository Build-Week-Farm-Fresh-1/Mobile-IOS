//
//  FarmerPalTests.swift
//  FarmerPalTests
//
//  Created by macbook on 1/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import FarmerPal

class FarmerPalTests: XCTestCase {


    func testFarmerRepresentationJSONParsing() {
        let decoder = JSONDecoder()
        
        do {
            let farmerRep = try decoder.decode(FarmerRepresentation.self, from: farmerRepDataAfterLogin)
            
            // Test (Expected, Actual)
            XCTAssertEqual(125, farmerRep.id)
            XCTAssertEqual("myFarmer90", farmerRep.username)
            XCTAssertEqual(984, farmerRep.zipCode)
            
        } catch {
            XCTFail("Error decoding farmerRepresentation: \(error)")
        }
    }

}
