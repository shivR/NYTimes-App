//
//  NYTimes_AppUITests.swift
//  NYTimes-AppUITests
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import XCTest

final class NYTimes_AppUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArticleListScreen() throws {
        app.launch()
        sleep(5)
        XCTAssertEqual(app.cells.count, 20)
//        app.cells.staticTexts["Dhaka"].tap()
//        XCTAssertTrue(app.navigationBars.staticTexts["Dhaka"].exists)
    }
    
    func testArticleDetailScreen() throws {
        app.launch()
        sleep(5)
        app.cells.firstMatch.tap()
        XCTAssertTrue(app.navigationBars.staticTexts["Detail"].exists)
        
        // click on back
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertEqual(app.cells.count, 20)     // we are on dashboard, perfect
    }
}
