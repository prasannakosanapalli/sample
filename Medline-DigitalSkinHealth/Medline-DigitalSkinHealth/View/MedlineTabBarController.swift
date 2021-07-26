//
//  MedlineTabBarViewController.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 30/01/21.
//

import UIKit

/// TabBar Item Titles
enum Item: String {
  case home = "Home"
  case formulary = "Formulary"
  case findcare = "Find Care"
  case feedback = "Feedback"
  case hotline = "Hotline"

}

class MedlineTabBarController : UITabBarController {
    
    var tabBarViewModel : MedlineTabBarViewModel!
    
    //MARK:- View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar setup
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.tabBarViewModel = MedlineTabBarViewModel()
        ///Setting TabBarContrller Controllers and Items
        initializeTabBarItems(items: self.tabBarViewModel.tabBarItems)
        
        self.delegate = self
        
        updateBarButtonItems()

        /* TabBar Item title font size */
        let fonSize :CGFloat = Device.size(small: 12, medium: 14, big: 18)

        let fontAttributes = [NSAttributedString.Key.font:MedlineAppUtils.setBoldFont(font_size: fonSize)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
    }
    
    //MARK:- Setting Bar Button Items
    /// Setting Bar Button Items
    func updateBarButtonItems() {
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: MedlineAssetConstant.kNotification), style:.plain, target:self, action: #selector(bellButtonClicked))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: MedlineAssetConstant.kMenu), style: .plain, target:self, action: #selector(menuButtonClicked))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    //MARK:- Left / Notification Button Click
    /// Left / Notification Button Click
    @objc func bellButtonClicked() {
        let notificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kNotificationViewControllerID) as! MedlineNotificationViewController
        self.show(notificationVC, sender: self)
    }
    
    //MARK:- Right / Menu Button Click
    /// Right / Menu Button Click
    @objc func menuButtonClicked() {
//        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:MedlineStoryboardIDConstant.kMenuViewControllerID) as! MedlineMenuViewController
//        self.show(menuVC, sender: self)
        
        //moving back to first on click
        navigationController?.popToRootViewController(animated: true)
    }
    
    /// Getting ViewControllers from TabBar Items data and setting them to TabBarController
    /// - Parameter items: TabBarItems data
    func initializeTabBarItems(items: [TabBarItem]) {
        self.viewControllers = self.tabBarViewModel.retrieveViewControllers(from: items)
    }
    
}

extension MedlineTabBarController : UITabBarControllerDelegate {
    
    //MARK:- TabBar Delegate Method
    /// TabBarController Delegate Method
    /// - Parameters:
    ///   - tabBarController: Base TabBarController
    ///   - viewController: ViewController which is added for each tab
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //let items = tabBarController.tabBar.items
        //print(items?.count)
        //tabBarController.tabBar.tintAdjustmentMode = .automatic
        //Setting ViewController Title
        switch viewController {
        case is MedlineHomeViewController:
            self.title = "Home"
        case is MedlineFormularyViewController:
            self.title = "Formulary"
        case is MedlineFindCareViewController:
            self.title = "Find Care"
        case is MedlineFeedbackViewController:
            self.title = "Feedback"
        case is MedlineHotlineViewController:
            self.title = "Hotline"
        default:
            break
        }
    }
}

/* //using Enum static data
func retrieveViewControllers(from items: [Item]) -> [UIViewController] {
  var viewControllers = [UIViewController]()
  for item in items {

    switch item {
    case .home:
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MedlineHomeVC") as! MedlineHomeScreenViewController
        let tabBarItem = UITabBarItem(title: item.rawValue, image: UIImage(systemName: "circle.fill"), selectedImage:nil)
        homeVC.tabBarItem = tabBarItem
        viewControllers.append(homeVC)
    case .formulary:
        let formularyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MedlineFormularyVC") as! MedlineFormularyViewController
        let tabBarItem2 = UITabBarItem(title: item.rawValue, image: UIImage(systemName: "circle.fill"), selectedImage:nil)

        formularyVC.tabBarItem = tabBarItem2
        viewControllers.append(formularyVC)
    default:
        break
    }
  }
    return viewControllers
}
*/
