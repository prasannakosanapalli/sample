//
//  MedlineHomeScreenTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Vijay Guruju on 15/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth
class MedlineHomeScreenTests: XCTestCase {

    var homeVC: MedlineHomeViewController!
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: StoryboardType.iphone, bundle: nil)
        homeVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kHomeViewControllerID) as? MedlineHomeViewController
        homeVC.loadViewIfNeeded()
        homeVC.viewWillDisappear(true)
        homeVC.viewDidLoad()
        try? testPopulateHomeFields()
    }
    //Papulate input values
    func testPopulateHomeFields() throws {
        
    }
   
    override func tearDownWithError() throws {
        homeVC = nil
    }

    func testLogoutButton() throws {
        XCTAssertNotNil(homeVC.logoutButtonClicked())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
