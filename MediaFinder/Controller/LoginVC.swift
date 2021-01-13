//
//  LoginVC.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet var signInBtn: UIButton!
    
    //MARK:- Properties
    var user: User!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = VCTitles.Login
        CustomNavigationBar()
        
        self.user = SQLiteManager.shared().getUser()
        UserDefaults.standard.setValue(false, forKey: UserDefaultsKeys.isLoggedIn)
    }

    //MARK:- Actions
      @IBAction func signUpBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        let registerationVC = sb.instantiateViewController(identifier: ViewContoller.RegisterationVC) as! RegisterationVC
        self.navigationController?.pushViewController(registerationVC, animated: true)
        
        SQLiteManager.shared().deleteUser()
        SQLiteManager.shared().deleteLastSearch()
        }
        
            
        @IBAction func signInBtnTapped(_ sender: UIButton) {
            if isDataEntered() {
            if isValid() {
              goToMediaListVC()
            }else {
              showAlert(message: "Insert Correct Email and Password")
                }
            }
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.isLoggedIn)
        }
    }

//MARK:- Priavte Methods
extension LoginVC {
    
       private func isDataEntered() -> Bool {
        guard let email = emailTxtField.text, !email.isEmpty  else {
            showAlert(message: "enter Email")
            return false
        }
        guard let password = passwordTxtField.text, !password.isEmpty  else {
            showAlert(message: "enter password")
            return false
        }
        return true
    }
    
   private func isValid() -> Bool {
        if emailTxtField.text! == self.user.email, passwordTxtField.text == self.user.password {
            return true
        }
        else {
            return false
        }
    }
   private func goToMediaListVC() {
        let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
        let mediaListVC = sb.instantiateViewController(identifier: ViewContoller.MediaListVC) as! MediaListVC
    self.navigationController?.pushViewController(mediaListVC, animated: true)
    }
    
    private func CustomNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
}
  

    
