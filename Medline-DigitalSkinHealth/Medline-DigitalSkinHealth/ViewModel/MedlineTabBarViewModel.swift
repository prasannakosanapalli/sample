//
//  MedlineTabBarViewModel.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import Foundation
import UIKit
class MedlineTabBarViewModel {
    
    ///Variables
    var tabBarItems : [TabBarItem]
    var viewControllers = [UIViewController]()
    
    //MARK:- Initialization
    //TODO:- Using hard coded data for now , need to get from API service
    init() {
        self.tabBarItems = [TabBarItem(itemTitle: Item.home.rawValue, itemImage: MedlineAssetConstant.kDot,storyBoardId: MedlineStoryboardIDConstant.kHomeViewControllerID ),TabBarItem(itemTitle: Item.formulary.rawValue, itemImage:MedlineAssetConstant.kDot,storyBoardId: MedlineStoryboardIDConstant.kFormularyViewControllerID),TabBarItem(itemTitle: Item.findcare.rawValue, itemImage:MedlineAssetConstant.kDot ,storyBoardId: MedlineStoryboardIDConstant.kFindCareViewControllerID),TabBarItem(itemTitle: Item.feedback.rawValue, itemImage:MedlineAssetConstant.kDot,storyBoardId: MedlineStoryboardIDConstant.kFeedbakViewControllerID),TabBarItem(itemTitle: Item.hotline.rawValue, itemImage: MedlineAssetConstant.kDot,storyBoardId: MedlineStoryboardIDConstant.kHotlineViewControllerID)]
        
        
    }
    
    /// Getting View controllers (with TabBar items data) that need to be added in Tabbar controller
    /// - Parameter items: Input data -> May vary based on user type
    /// - Returns: list of viewcontrollers need to in TabBar Controller
    func retrieveViewControllers(from items: [TabBarItem]) -> [UIViewController] {
        
        for item in items {
          let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: item.storyBoardId)
          let tabBarItem = UITabBarItem(title: item.itemTitle, image: UIImage(named:item.itemImage), selectedImage:nil)
          viewController.tabBarItem = tabBarItem
          self.viewControllers.append(viewController)
          
        }
         return self.viewControllers
    }
    
}
