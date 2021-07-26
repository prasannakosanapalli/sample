//
//  ViewController.swift
//  MedlineOnBoardSample
//
//  Created by Vijay Guruju on 28/01/21.
//

import UIKit

class MedlineOnBoardingScreenViewController : UIViewController {

    //MARK:- Outlet connections
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Registering custom collectionview cell 
        collectionView.register(UINib(nibName: MedlineAppConstant.kImageCollectionViewCellId, bundle: nil), forCellWithReuseIdentifier: MedlineAppConstant.kImageCollectionViewCellId)
        
        pageControl.numberOfPages = MedlineData.images.count
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    //MARK:- PageControl value change action
    @IBAction func pageControlChanged(_ sender: Any) {
        let indexPath =  IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at:indexPath , at:[.left,.right], animated: true)
    }
    
}

extension MedlineOnBoardingScreenViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MedlineData.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedlineAppConstant.kImageCollectionViewCellId, for: indexPath) as! MedlineImageSliderCollectionViewCell
        cell.imgView.image = MedlineData.images[indexPath.item]
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width:self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    //MARK:- PageCongtrol update
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left * 2)
        let index = scrollView.contentOffset.x / width
        let roundedWidth = round(index)
        self.pageControl.currentPage = Int(roundedWidth)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //updating pagecontrol's current page
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    
    }
    
    ///Updating pagecontrol's current page
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)

    }

    
}
