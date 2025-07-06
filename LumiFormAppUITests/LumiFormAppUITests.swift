//
//  LumiFormAppUITests.swift
//  LumiFormAppUITests
//
//  Created by Angélica Rodrigues on 03/07/2025.
//

import XCTest
@testable import LumiFormApp

final class MainPageUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testMainPage_UIElementsExist() {
        let mainPage = app.scrollViews["itemsComponentView"]
        XCTAssertTrue(mainPage.exists)
    }

    func testTableOfContentsRedirect() {
        let itemsComponent = app.scrollViews["itemsComponentView"]
        XCTAssertTrue(itemsComponent.exists)
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Table"].tap()
        
        let secondPageStaticText = app.scrollViews.otherElements.staticTexts["Second Page"]

        if secondPageStaticText.waitForExistence(timeout: 2) {
            secondPageStaticText.tap()
        } else {
            XCTFail("Failed to find 'Second Page' static text to tap within 2 seconds")
        }
        
        let secondPageText = app.staticTexts["Second Page"]
        XCTAssertTrue(secondPageText.waitForExistence(timeout: 2))

    }
}
