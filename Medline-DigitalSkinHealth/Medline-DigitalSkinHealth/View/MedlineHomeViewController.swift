//
//  MedlineHomeViewController.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import UIKit
//import SwiftKeychainWrapper

class MedlineHomeViewController: MedlineBaseViewController {

    //MARK:- Outlet connections
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var greetLabel: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chipCollectionView: UICollectionView!
    
    //var homeViewModel : MedlineHomeViewModel!
    //MARK:- View
    override func viewDidLoad() {
        super.viewDidLoad()
      // TODO: Testing keychain - Save
      //  let saveSuccessful: Bool = KeychainWrapper.standard.set("876543", forKey: "userPassword")
       // print("Save was successful: \(saveSuccessful)")

        //Registering custom collectionview cell with nib
        bannerCollectionView.register(UINib(nibName: MedlineAppConstant.kImageCollectionViewCellId, bundle: nil), forCellWithReuseIdentifier: MedlineAppConstant.kImageCollectionViewCellId)
        
        //PageControl input data
//        pageControl.numberOfPages = MedlineData.images.count
//        self.homeViewModel = MedlineHomeViewModel()
//        searchBar.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        pageControl.isHidden = true
    
        //var button
        let rightBarButtonItem = UIBarButtonItem(title : MedlineAppConstant.kLogout , style: .plain, target:self, action: #selector(logoutButtonClicked))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .blue
    }
    override func viewWillDisappear(_ animated: Bool) {
        // Dismissing keyboard
        self.navigationController?.navigationBar.isHidden = true

    }
   
    //MARK:- Left / Notification Button Click
    /// Left / Notification Button Click
    @objc func logoutButtonClicked() {
//        let notificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MedlineStoryboardIDConstant.kNotificationViewControllerID) as! MedlineNotificationViewController
//        self.show(notificationVC, sender: self)
        navigationController?.popToRootViewController(animated: true)
    }
//    override func viewDidLayoutSubviews() {
//        //Search bar textfield layout change
//        if let searchBarTextField = searchBar.value(forKey: MedlineAppConstant.kSearchTextField) as? UITextField {
//            searchBarTextField.backgroundColor = .white
//            searchBarTextField.leftView = nil
//            let image = UIImage(named: MedlineAssetConstant.kBarcode)
//            let imageView:UIImageView = UIImageView.init(image: image)
//            searchBarTextField.rightView = imageView
//            searchBarTextField.rightViewMode = .always
//            let scannerGesture = UITapGestureRecognizer(target: self, action: #selector(scannerClicked))
//            imageView.addGestureRecognizer(scannerGesture)
//            imageView.isUserInteractionEnabled = true
//
//        }
//    }
//
//    //MARK:- Scanner Icon Click Action
//    @objc func scannerClicked(){
//        print("Scanner Clicked")
//    }
//
//    //MARK:- Page Controll value change
//    @IBAction func pageControlChanged(_ sender: UIPageControl) {
//        let indexPath =  IndexPath(item: pageControl.currentPage, section: 0)
//            bannerCollectionView.scrollToItem(at:indexPath , at:[.left,.right], animated: true)
//        }
//
    }

/* commented for now
extension MedlineHomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == bannerCollectionView) {
            return MedlineData.images.count
        }
        if (collectionView == cardCollectionView) {
            return 3 //
        }
        if (collectionView == chipCollectionView) {
            return 6 //
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedlineAppConstant.kImageCollectionViewCellId, for: indexPath) as! MedlineImageSliderCollectionViewCell
            cell.imgView.image = MedlineData.images[indexPath.item]
             return cell
         }
        if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedlineAppConstant.kCardViewCollectionViewCellId, for: indexPath) as! MedlineCardViewCollectionViewCell
            cell.titleLabel.text = self.homeViewModel.carViewData[indexPath.item].title
             return cell
            
        }
        if (collectionView == chipCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedlineAppConstant.kChipCollectionVieCellId, for: indexPath) as! MedlineChipCollectionViewCell
            cell.titleLabel.text = self.homeViewModel.chipsData[indexPath.item].chipTitle
             return cell
        } else {
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: self.bannerCollectionView.frame.width, height: self.bannerCollectionView.frame.height)
        }
        if collectionView == cardCollectionView {
            return CGSize(width: self.cardCollectionView.frame.width / 3 , height: self.cardCollectionView.frame.height)
        }
        if collectionView == chipCollectionView {
            let cellHeight:CGFloat = Device.size(small: 50, medium: 60, big: 80)
            return CGSize(width: self.chipCollectionView.frame.width / 2 - 10 , height: cellHeight)
            
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Banner selction
        print("you have selected item \(indexPath.item)")//selection check
        
    }
    
    //MARK:- Page control update
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left * 2)
        let index = scrollView.contentOffset.x / width
        let roundedWidth = round(index)
        self.pageControl.currentPage = Int(roundedWidth)
    }
    
    ///updating pagecontrol's current page
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)

    }
    
    ///updating pagecontrol's current page
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    
}

extension MedlineHomeViewController : UISearchBarDelegate {
    
    //MARK:- SearchBar delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    
}
*/

