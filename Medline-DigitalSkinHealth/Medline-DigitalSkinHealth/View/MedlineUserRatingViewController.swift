//
//  UserRatingViewController.swift
//  UserRatingsScreen
//
//  Created by Chaitanya Kumari U on 19/02/21.
//

import UIKit
import StoreKit

class MedlineUserRatingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Rateus_Action(_ sender: Any) {
        
        if #available(iOS 10.3, *) {
            
            SKStoreReviewController.requestReview()
            
        } else {
            
            let appID = "958625272"
            
            // (Option 1) Open App Page
            // let urlStr = "https://itunes.apple.com/app/id\(appID)"
            
            // (Option 2) Open App Review Page
            let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review"
            
            guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
            }
            
            
        }
        
    }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
