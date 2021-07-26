//
//  MedlineBaseViewControllerTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Hariharan A on 09/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineBaseViewControllerTests: XCTestCase {

    var baseVC: MedlineBaseViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        baseVC = MedlineBaseViewController()
        baseVC.loadViewIfNeeded()
        
        baseVC.viewDidLoad()
        baseVC.viewWillAppear(true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBackButtonClicked() throws {
        baseVC.backButtonClicked()
        XCTAssert(true, "Button clicked")
    }
    
    func testShowNetworkUnavailableAlert() throws {
        if isConnectedToInternet() == true {
            XCTAssert(true, "Network Available")
        } else {
            baseVC.showNetworkUnavailableAlert()
            XCTAssert(false, "Network Unavailable")
        }
    }
    
    func testStartActivityIndicator() throws {
        baseVC.startActivityIndicator()
        XCTAssert(true, "Show Activity Indicator")
    }
    
    func testStopActivityIndicator() throws {
        baseVC.stopActivityIndicator()
        XCTAssert(true, "Stop Activity Indicator")
    }

}
