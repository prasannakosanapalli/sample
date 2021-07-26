//
//  MedlineWebViewControllerTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Hariharan A on 11/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineWebViewControllerTests: XCTestCase {

    var webVC: MedlineWebContentViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Step 1. Create an instance of UIStoryboard
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        webVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kWebContentViewControllerID) as? MedlineWebContentViewController
        // Step 3. Make the viewDidLoad() execute.
        webVC.loadViewIfNeeded()
        webVC.viewWillAppear(true)
        webVC.viewDidLoad()
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
}
