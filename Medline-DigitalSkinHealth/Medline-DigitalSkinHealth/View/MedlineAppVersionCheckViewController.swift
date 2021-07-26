//
//  MedlineVersionCheckViewController.swift
//  Medline-DigitalSkinHealth
//
//  Created by Vijay Guruju on 18/02/21.
//

import UIKit

class MedlineAppVersionCheckViewController: UIViewController {

    var modelclassval = MedlineAppVersionCheck()
    var userdatamodel = MedlineUserManagement()
    
    var userid : String?
    
    @IBOutlet weak var useridtextfeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    }
    
    //Mark :- Check Appversion button_Action
    
    @IBAction func Checkappversion_Action(_ sender: Any) {
        
        userid = useridtextfeild.text
        useralertaction()
        
    }
    
    //Mark :- showing the alert if the user having app updated version
    
    func useralertaction() {
        let modeldata = modelclassval.checkversions(userID: userid ?? "")
        if modeldata.5 == false {
        if(modeldata.0 == true){
            
            OperationQueue.main.addOperation({
                
                let alert = UIAlertController(title: modeldata.2, message: modeldata.3, preferredStyle: .alert)
                
                if(modeldata.1 == false) {
                    let Ignoreoption = UIAlertAction(title: "Ignore", style: .cancel, handler: { action in
                        self.userdatamodel.Updateuserdetails(userid: self.userid ?? "")
                    })
                    alert.addAction(Ignoreoption)
                    
                }
                let updateaction = UIAlertAction(title: "Update", style: .default, handler: { action in
                    
                    if let url = URL(string: modeldata.4),
                       
                       UIApplication.shared.canOpenURL(url){
                        
                        UIApplication.shared.open(url, options: [:]) { (opened) in
                            
                            if(opened){
                                print("App Store Opened")
                            }
                        }
                        
                    } else {
                        print("Can't Open URL on Simulator")
                        
                    }
                    
                })
                alert.addAction(updateaction)
                
                DispatchQueue.main.async(execute: {
                    
                    self.present(alert, animated: true)
                })
                
            })
            
        }
        }
        
    }
    
//    //Mark :- get user details based on userid
//
//    func getuseracceptencedetails(){
//
//        userdatamodel.loadData()
//        userdatamodel.Updateuserdetails(userid: userid!)
//
//
//    }
    
        
}

extension MedlineAppVersionCheckViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
