//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Jeff_Terry on 12/26/21.
//

import XCTest

class Tests_iOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSlowSum() async throws {
            
        let mathClass = MathClass()
            
        await mathClass.slowSum(i: 1, addend1: 2.0, addend2: 3.0, randomSleep: 2)
            
        let returnString = mathClass.calculationString
            
        XCTAssertEqual(returnString, "The sum of the 1th addition 2.0 and 3.0 is 5.0 with sleep time 2 sec.\n")
        
       
            
            
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
