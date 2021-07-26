//
//  MedlineFullScreenMessageViewController.swift
//  XCTestSample
//
//  Created by Sunil Kumar Jaiswal on 18/02/21.
//

import UIKit

class MedlineFullScreenMessageViewController: MedlineBaseViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var greetTitleLabel: UILabel!
    var message: String = ""
    var greetTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomMedlineNavigationBar(withBack: false)

        greetTitleLabel.text = greetTitle
        messageLabel.text = message
    }
    
    @IBAction func continueToLoginAction(_ sender: Any) {
        // Navigate to login screen
        self.navigationController?.popToRootViewController(animated: true)
    }
}
