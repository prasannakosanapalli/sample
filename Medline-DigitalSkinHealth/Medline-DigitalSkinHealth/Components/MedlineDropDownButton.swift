//
//  MedlineDropDownButton.swift
//  Medline-DigitalSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
// 

import Foundation
import UIKit

protocol DropDownProtocol {

    func addAnotherAccount()
}

class MedlineDropDownButton: UIButton {
    var delegate : DropDownProtocol?
    private var tableView = UITableView()
    private var backView = UIView()
    private var useAnotherAccountButton = UIButton()
    private var dropdownView = UIView()
    private var dropDownViewModel : MedlineDropDownViewModel?
    private var selectedIndex = 0
    
    //MARK:- Initilisation
    override init(frame: CGRect) {
            super.init(frame: frame)
            layoutSetup()
    }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            layoutSetup()
          
    }
    
    //MARK:- Layout updates
    override func layoutSubviews() {
            super.layoutSubviews()
            layoutSetup()
    }
    
    //MARK:- Dropdown Button layout setup
    private func layoutSetup() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderWidth = isDeviceTypeIPad() ? 1.4 : 0.5
        let borderColor = UIColor(named: MedlineColor.kDropdownButtonBorder)
        self.layer.borderColor = borderColor?.cgColor
        self.semanticContentAttribute = .forceRightToLeft
        self.setImage(UIImage(named: MedlineAssetConstant.kDropdown), for: .normal)
        self.setTitleColor(UIColor(named: MedlineColor.kBlackShade), for: .normal)
       // self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
        let fontSize:CGFloat = Device.size(small: 1, medium: 1, big: 20)
        self.titleLabel?.font = setRegularFont(font_size: fontSize)

    }
}


extension MedlineDropDownButton: UITableViewDataSource,UITableViewDelegate {
    
    //MARK:- TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dropDownViewModel?.userData.count ?? 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MedlineAppConstant.kDropDownCellId )
        cell?.textLabel?.text = self.dropDownViewModel?.userData[indexPath.row].userEmail
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = setRegularFont(font_size: 14)
        cell?.imageView?.image = UIImage(named: MedlineAssetConstant.kTickmark)

        if (selectedIndex == indexPath.row) {
            cell?.imageView?.isHidden = false
            cell?.textLabel?.textColor = UIColor(named: MedlineColor.kBlackShade)

        } else {
            cell?.imageView?.isHidden = true
            cell?.textLabel?.textColor = UIColor(named: MedlineColor.kDropdownUnselected)
        }
        if (indexPath.row == (dropDownViewModel?.userData.count)! - 1) {
            tableView.separatorStyle = .none
            
        } else {
            tableView.separatorStyle = .singleLine
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1.0)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: (cell.frame.size.height) - separatorHeight, width: screenSize.width, height: separatorHeight))
        let separatorColor = UIColor(named:MedlineColor.kDropdownSeperator)
        additionalSeparator.backgroundColor = separatorColor
        cell.addSubview(additionalSeparator)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(MedlineAppConstant.kDropdownRowHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setTitle(self.dropDownViewModel?.userData[indexPath.row].userEmail, for: .normal)
        self.selectedIndex = indexPath.row
        removeDropDownView()
    }
    
    
        
    /// Setup dropdowm view
    /// - Parameters:
    ///   - frame: dropdown button frame
    ///   - parentVC: Viewcontroller from where we are showing dropdown
    ///   - dropDownData: data to show dropdown
    func setupDropDownView(parentVC:UIViewController,dropDownData:[UserData]){
        
        let frame = self.frame
        // from design
        let rowHeight = MedlineAppConstant.kDropdownRowHeight
        let footerButtonHeight = MedlineAppConstant.kDropdownFooterHeight
        let dropdowViewXposition:CGFloat = CGFloat(MedlineAppConstant.kDropdownXPosition)
        let dropdownViewAdditionalWidth:CGFloat = 103
        /*Info
         dropdownView :- Dropdown which comes from Button onclick
         tableView :- dropdown list
         useAnotherAccountButton :- Use another Button below tableview
         backView:- Background view for dropdown effect
         */
        
        //Set intial frames for all views
        self.backView.frame = parentVC.view.frame
        self.dropdownView.frame = CGRect(x: dropdowViewXposition, y: frame.origin.y + frame.height, width: frame.width + dropdownViewAdditionalWidth, height: 0)
        self.tableView.frame = CGRect(x: 0.5, y: 0, width: self.dropdownView.frame.width - 1, height: 0)
        self.useAnotherAccountButton.frame =  CGRect(x: Int(0.5), y: Int(self.tableView.frame.height), width: Int(self.dropdownView.frame.width - 1), height: 0)

        //Register tableview cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: MedlineAppConstant.kDropDownCellId)
        
        //set delegate and data sounrce for tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.dropDownViewModel = MedlineDropDownViewModel(userData: dropDownData)
        tableView.reloadData()
        
        //adding sub views
        parentVC.view.addSubview(backView)
        parentVC.view.addSubview(dropdownView)
        self.dropdownView.addSubview(tableView)
        dropdownView.addSubview(useAnotherAccountButton)

        //Tap gesture for backgroung view for dismissing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeDropDownView))
        self.backView.addGestureRecognizer(tapGesture)
        self.backView.alpha = 0

        //showing dropdown tableview with anumation
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
            
                        self.backView.alpha = 0.5
                        self.useAnotherAccountButton.alpha = 1.0
                        self.dropdownView.frame = CGRect(x: dropdowViewXposition, y: frame.origin.y + frame.height + 9, width: frame.width + dropdownViewAdditionalWidth , height: CGFloat((dropDownData.count > 5 ? 350 : dropDownData.count * rowHeight + footerButtonHeight)))
                        self.tableView.frame = CGRect(x: 0.5, y: 0, width: self.dropdownView.frame.width - 1, height: CGFloat(self.dropdownView.frame.height  - CGFloat(footerButtonHeight)))
                        self.useAnotherAccountButton.frame =  CGRect(x: Int(0.5), y: Int(self.tableView.frame.height), width: Int(self.dropdownView.frame.width - 1), height: footerButtonHeight)
                        
                       }, completion: nil)
        
        //Another account Button layout
        useAnotherAccountButton.setTitle(MedlineAppConstant.kUseAnotherAccount, for: .normal)
        useAnotherAccountButton.setImage(UIImage(named: MedlineAssetConstant.kPlus), for: .normal)
        useAnotherAccountButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        useAnotherAccountButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        useAnotherAccountButton.contentHorizontalAlignment = .left
        useAnotherAccountButton.titleLabel?.font = setSemiboldFont(font_size: 14)
        useAnotherAccountButton.backgroundColor = UIColor(named: MedlineColor.kNewUserButton)
        useAnotherAccountButton.addTarget(self, action: #selector(useAnotherAccountClicked), for: .touchUpInside)
        
        //Tableview layout
        let separatorColor = UIColor(named:MedlineColor.kDropdownSeperator)
        tableView.separatorColor = separatorColor
        tableView.bounces = false
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        //dropdown view  border
        dropdownView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        dropdownView.layer.cornerRadius = 9
        dropdownView.layer.borderWidth = 1.0
        dropdownView.layer.borderColor = separatorColor?.cgColor
//        dropdownView.layer.masksToBounds = true
        
        //shadow for dropdown view
        dropdownView.layer.applySketchShadow(
            color: UIColor(named:MedlineColor.kBorderColor)!,
            alpha: 1.0,
            x: 5,
            y: 3,
            blur: 7,
            spread: 0
        )
    
        useAnotherAccountButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        useAnotherAccountButton.layer.cornerRadius = 9
        useAnotherAccountButton.layer.masksToBounds = true

        self.dropdownView.center.x = self.backView.center.x
        parentVC.view.bringSubviewToFront(dropdownView)
    }
    
    //MARK:- Remove dropdown view
    @objc func removeDropDownView() {
        let frame = self.frame
        let dropdowViewXposition:CGFloat = 37
        let dropdownViewAdditionalWidth:CGFloat = 103
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.backView.alpha = 0
                        self.useAnotherAccountButton.alpha = 0
                        self.dropdownView.frame = CGRect(x: dropdowViewXposition, y: frame.origin.y + frame.height , width: frame.width + dropdownViewAdditionalWidth, height: 0)
                        self.tableView.frame = CGRect(x: 0.5, y: 0, width: self.dropdownView.frame.width - 1, height: 0)
                        self.useAnotherAccountButton.frame = CGRect(x: Int(0.5), y: 0, width: Int(self.dropdownView.frame.width - 1), height:0)
                        
                        self.backView.removeFromSuperview()
                        //self.dropdownView.removeFromSuperview()
                        self.dropdownView.center.x = self.backView.center.x
                        self.dropdownView.layer.masksToBounds =  true


                       }, completion: nil)
        
    }

    //MARK:- Delegate method
    @objc func useAnotherAccountClicked(){
        
        self.delegate?.addAnotherAccount()
        print("Adding another account")
        removeDropDownView()
    }
}

// Shadow effect
extension CALayer {
  func applySketchShadow(
    color: UIColor = UIColor(named:MedlineColor.kBorderColor)!,
    alpha: Float = 0.3,
    x: CGFloat = 5,
    y: CGFloat = 3,
    blur: CGFloat = 7,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
