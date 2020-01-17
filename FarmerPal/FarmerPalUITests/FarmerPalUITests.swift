//
//  FarmerPalUITests.swift
//  FarmerPalUITests
//
//  Created by macbook on 1/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest

class FarmerPalUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testConsumerLogin() {
    
//        app.buttons["Log In"].tap()
//        app.staticTexts["ConsumerGreetingLabel"].tap()
        
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["Client"].tap()

        let usernameTextField = app.textFields["Username"]
        usernameTextField.tap()
        usernameTextField.typeText("consumer1")

        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("t12345678@")

        let loginButton = app.buttons["Log In"]
        loginButton.tap()

        app.staticTexts["Welcome User"].tap()
//        XCTAssertEqual(accessibilityIden, <#T##expression2: Equatable##Equatable#>)
}

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
