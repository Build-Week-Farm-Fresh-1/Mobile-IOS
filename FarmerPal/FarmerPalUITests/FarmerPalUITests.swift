//
//  FarmerPalUITests.swift
//  FarmerPalUITests
//
//  Created by macbook on 1/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import FarmerPal

class FarmerPalUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testSignUpFarmer() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["SignUpButtonIdentifier"].tap()
       
        let firstNameTextField = app.textFields["firstNameTextFieldIdentifier"]
        let lastNameTextField = app.textFields["lastNameTestFieldIdentifier"]
        let phoneNumTextField = app.textFields["phoneNumTextFieldIdentifier"]
        let usernameTextField = app.textFields["signUpUsernameTestFieldIdentifier"]
        let passwordTextField = app.secureTextFields["signUpPasswordTextFieldIdentifier"]
        let cityTextField = app.textFields["cityTestFieldIdentifier"]
        let stateTextField = app.textFields["stateTextFieldIdentifier"]
        let zipCodeTextField = app.textFields["zipCodeTestFieldIdentifier"]
        let emailTextField = app.textFields["emailTextFieldIdentifier"]
        
        let accountSelectionStaticText = app.staticTexts["Account Selection"]
        let farmerButton = app.buttons["farmerButtonIdentifier"]
        let signUpButton = app.buttons["signUpUserButtonIdentifier"]
        let welcomeLabel = app.staticTexts["welcomeLabelIdentifier"]
        
        farmerButton.tap()
        
        firstNameTextField.tap()
        firstNameTextField.typeText("testingFarmer2030")
        accountSelectionStaticText.tap()
        
        lastNameTextField.tap()
        lastNameTextField.typeText("testingFarmer2030")
        accountSelectionStaticText.tap()
        
        phoneNumTextField.tap()
        phoneNumTextField.typeText("102030")
        accountSelectionStaticText.tap()
        
        cityTextField.tap()
        cityTextField.typeText("testingFarmer2030")
        accountSelectionStaticText.tap()
        
        stateTextField.tap()
        stateTextField.typeText("testingFarmer2030")
        accountSelectionStaticText.tap()
        
        zipCodeTextField.tap()
        zipCodeTextField.typeText("102030")
        accountSelectionStaticText.tap()
        
        emailTextField.tap()
        emailTextField.typeText("testingFarmer2030@email.com")
        accountSelectionStaticText.tap()
        
        usernameTextField.tap()
        usernameTextField.typeText("testingFarmer2030")
        accountSelectionStaticText.tap()
        
        passwordTextField.tap()
        passwordTextField.typeText("testingFarmer2030!")
        accountSelectionStaticText.tap()
        
        signUpButton.tap()
        
        XCTAssertEqual(welcomeLabel.label, "Welcome testingFarmer2030")
    }

    func testFarmerLogin() {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Farmer"].tap()
        
        let usernameTextField = app.textFields["usernameTextFieldIdentifier"]
        let emailTextField = app.textFields["emialTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        
        let viewwithimageElement = app.otherElements["ViewWithImage"]
        let loginButton = app.buttons["loginButtonIdentifier"]
        let welcomeLabel = app.staticTexts["welcomeLabelIdentifier"]
        
        usernameTextField.tap()
        usernameTextField.typeText("testingFarmer2030")
        viewwithimageElement.tap()
        
        emailTextField.tap()
        emailTextField.typeText("testingFarmer2030@email.com")
        viewwithimageElement.tap()
        
        passwordTextField.tap()
        passwordTextField.typeText("testingFarmer2030!")
        viewwithimageElement.tap()
        
        loginButton.tap()
        
        XCTAssertEqual(welcomeLabel.label, "Welcome testingFarmer2030")
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
