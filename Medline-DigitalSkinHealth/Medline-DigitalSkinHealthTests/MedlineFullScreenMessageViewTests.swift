//
//  MedlineFullScreenMessageViewTests.swift
//  Medline-DigitalSkinHealthTests
//
//  Created by Sunil Kumar Jaiswal on 10/03/21.
//

import XCTest
@testable import Medline_DigitalSkinHealth

class MedlineFullScreenMessageViewTests: XCTestCase {

    var fullScreenMessageVC: MedlineFullScreenMessageViewController?
    
    override func setUpWithError() throws {
        //Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: retrieveStoryboardName(), bundle: nil)
        //Step 2. Instantiate UIViewController with Storyboard ID
        fullScreenMessageVC = storyboard.instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kFullScreenMessageViewControllerID) as? MedlineFullScreenMessageViewController
        //Step 3. Make the viewDidLoad() execute.
        fullScreenMessageVC?.loadViewIfNeeded()
        fullScreenMessageVC?.viewDidLoad()
    }

    override func tearDownWithError() throws {
        //Put teardown code here. This method is called after the invocation of each test method in the class.
        fullScreenMessageVC = nil
    }
    
    func testContinueToLoginAction() throws {
        fullScreenMessageVC?.continueToLoginAction(UIButton())
    }

    func testExample() throws {
        //This is an example of a functional test case.
        //Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        //This is an example of a performance test case.
        self.measure {
            //Put the code you want to measure the time of here.
        }
    }
}
