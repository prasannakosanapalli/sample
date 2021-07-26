//
//  BaseViewController.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PromiseKit

/// This ViewController is base for all the viewcontroller. Common UI stuffs are added in this ViewController and same can be reused in other viewcontroller
class MedlineBaseViewController: UIViewController {

    override func viewDidLoad() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        super.viewDidLoad()
        medlineBackgroundImage()
        
        self.navigationController?.navigationBar.isHidden = true
        //addCustomMedlineNavigationBar(withBack: true)
        // Do any additional setup after loading the view.
    }
    
    /// Method is used to add Background Image in view controller
    func medlineBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let bgName = isDeviceTypeIPad() ? "MedlineBg_ipad" : "MedlineBg"
        backgroundImage.image = UIImage(named: bgName)
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    func addCustomMedlineNavigationBar(withBack: Bool) {
        let backButton = UIButton()
        var navFrame: CGRect!
        
        let headerLogoImage = isDeviceTypeIPad() ? MedlineAssetConstant.kHeaderLogoIpad : MedlineAssetConstant.kHeaderLogo
        let backButtonImage = isDeviceTypeIPad() ? MedlineAssetConstant.kBackIpad : MedlineAssetConstant.kBack
        let image = UIImage(named: headerLogoImage)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        
        if isDeviceTypeIPad() {
            navFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 175)
            imageView.frame = CGRect(x: 0, y: 100, width: 195, height: 70)
            backButton.frame = CGRect(x: 50, y: 118, width: 40, height: 40)
        } else {
            navFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Device.isNotched ? 112 : 86)
            imageView.frame = CGRect(x: 0, y: Device.isNotched ? 72 : 46, width: 112, height: 40)
            backButton.frame = CGRect(x: 22, y: Device.isNotched ? 72 : 46, width: 40, height: 40)
        }
        backButton.setImage(UIImage.init(named: backButtonImage), for: .normal)
        backButton.addTarget(self, action:#selector(self.backButtonClicked), for: .touchUpInside)
        let customNav = UIView.init(frame: navFrame)
        imageView.center.x = customNav.center.x
        customNav.backgroundColor = .white
        customNav.addSubview(imageView)
        
        if withBack == true {
            backButton.isHidden = false
            customNav.addSubview(backButton)
        } else {
            backButton.isHidden = true
        }
        view.addSubview(customNav)
    }
    
    
    @objc func backButtonClicked() {
        print("Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Method is used to setup the NavigationBar in ViewController
    func addMedineNavigationBar(withBack: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)

        navigationColor(barColor: UIColor.white)
        medlineNavigationLogo()
        if withBack == true {
            medlineNavigationBackButton()
        }
    }
    
    /// Method is used to set back button in navigation bar and button action is 'backToPrevious''
    func medlineNavigationBackButton() {
        let backImage: UIImage = UIImage(named: "back_button") ?? UIImage()
        let frameimg: CGRect = CGRect(x: 0, y: 0, width: 13, height: 21)
        let backButton = UIButton(type: .system)
        backButton.frame = frameimg
        backButton.setBackgroundImage(backImage, for: .normal)
        backButton.addTarget(self, action:#selector(backToPrevious), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        backButton.isHidden = false
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        flexibleSpace.width = -7
        navigationItem.leftBarButtonItems = [flexibleSpace, backBarButton]
    }
    
    /// Method is used to set color for NavigationBar
    /// - Parameter barColor: set color for navigationbar
    func navigationColor(barColor: UIColor) {
        navigationController?.navigationBar.tintColor = barColor
        navigationController?.navigationBar.barTintColor = barColor
        navigationController?.navigationBar.backgroundColor = barColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                                    for: .default)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    /// Method is used to set Logo in navigationbar
    func medlineNavigationLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 112, height: 100))
        imageView.contentMode = .scaleAspectFit
        let navImagmeName = isDeviceTypeIPad() ? "logoLarge" : "MedlineNavLogo"
        let image = UIImage(named: navImagmeName)
        imageView.image = image
                
        navigationItem.titleView = imageView
    }
    
    /// This method will call when back button taps and current screen will pop to previous screen
    @IBAction func backToPrevious() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    /// This method is used to show activity indicator while screen is loading/waiting for some other stuff, this method will execute in MainThread
    func startActivityIndicator() {
        DispatchQueue.main.async {
            
            let existView = self.view.viewWithTag(1000)
            if existView != nil {
                existView?.removeFromSuperview()
            }
            
            let loadingView: UIView = UIView.init(frame: CGRect(x:0, y: 0, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height))
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            loadingView.tag = 1000
            loadingView.isUserInteractionEnabled = true
            
            let myActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: loadingView.bounds.width, height: CGFloat(44)),
                                                  type: NVActivityIndicatorType.ballSpinFadeLoader)
            myActivityIndicator.center = loadingView.center
            myActivityIndicator.color = UIColor(named: MedlineColor.kBlueMedline)!
            myActivityIndicator.startAnimating()

            loadingView.addSubview(myActivityIndicator)
            self.view.addSubview(loadingView)
        }
    }
    
    
    /// This method is used to stop activity indicator
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            let view = self.view.viewWithTag(1000)
            if view != nil {
                view?.removeFromSuperview()
            }
        }
    }
    
    /// This method is used to show activity indicator for Promisekit while screen is loading/waiting for response
    func startPromiseActivityIndicator() -> Guarantee<Void> {
        let existView = self.view.viewWithTag(2000)
        if existView != nil {
            existView?.removeFromSuperview()
        }
        
        let loadingView: UIView = UIView.init(frame: CGRect(x:0, y: 0, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height))
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        loadingView.tag = 2000
        
        let myActivityIndicator = NVActivityIndicatorView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: loadingView.bounds.width, height: CGFloat(44)),
                                                          type: NVActivityIndicatorType.ballSpinFadeLoader)
        myActivityIndicator.center = loadingView.center
        myActivityIndicator.color = UIColor(named: MedlineColor.kBlueMedline)!
        myActivityIndicator.startAnimating()

        loadingView.addSubview(myActivityIndicator)
        self.view.addSubview(loadingView)
        return Guarantee()
    }
    
    /// This method is used to stop activity indicator with PromiseKit
    func stopPromiseActivityIndicator() -> Guarantee<Void> {
        let view = self.view.viewWithTag(2000)
        if view != nil {
            view?.removeFromSuperview()
        }
        return Guarantee()
    }
    
    /// This method is used to show Alert and this will execute in 'Main thread'
    /// - Parameters:
    /// - title: Alert Title
    /// - message: Alert Message
    /// - actionTitle: Button Title
    func showAlert(title:String, message:String, actionTitle:String) {
        DispatchQueue.main.async {
            let alertCtrl:UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            
            let okAction:UIAlertAction = UIAlertAction.init(title: actionTitle, style: .cancel, handler: { (actionHandler) in
            })
            alertCtrl.addAction(okAction)
            
            self.present(alertCtrl, animated: true, completion: nil)
        }
    }
    
    /// Method is used to show alert for 'Network unavaialble'
    func showNetworkUnavailableAlert() {
        showAlert(title: localizedString("ERR_CONNECTION_TITLE"), message: localizedString("ERR_CONNECTION"), actionTitle: kOkay)
    }

    /// Method is used to set Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Dismiss keyboard
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
