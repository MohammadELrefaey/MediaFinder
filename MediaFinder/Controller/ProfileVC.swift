//
//  ProfileVC.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var phoneLabel: LabelBorder!
    @IBOutlet var nameLable: LabelBorder!
    @IBOutlet var addressLabel: LabelBorder!
    @IBOutlet var genderLabel: LabelBorder!
    
    //MARK:- Properties
    var user: User!   
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = VCTitles.Profile
        CustomNavigationBar()
        self.user = SQLiteManager.shared().getUser()
        printData()
    }
    
    //MARK:- Actions
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        SQLiteManager.shared().deleteLastSearch()
        goToLoginVC()
    }
}
    //MARK:- Private Methods
extension ProfileVC {
   private func printData() {
        nameLable.text = " " + self.user.name
        phoneLabel.text = " " + self.user.phone
        addressLabel.text = " " + self.user.address
        genderLabel.text = " " + self.user.gender.rawValue
    }
    
   private func goToLoginVC() {
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: ViewContoller.LoginVC) as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func CustomNavigationBar() {
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
}
