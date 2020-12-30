//
//  LoginVC.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet var signInBtn: UIButton!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = UserDefaulsManager.shared().get()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func isDataEntered() -> Bool {
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
    
    func isValid() -> Bool {
        if emailTxtField.text! == self.user.email, passwordTxtField.text == self.user.password {
            return true
        }
        else {
            return false
        }
    }
    
    
    func goToMediaListVC() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
        let mediaListVC = sb.instantiateViewController(identifier: VC.MediaListVC) as! MediaListVC
    self.navigationController?.pushViewController(mediaListVC, animated: true)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let registerationVC = sb.instantiateViewController(identifier: VC.RegisterationVC) as! RegisterationVC
      //  self.present(registerationVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerationVC, animated: true)
    }
    
        
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        if isDataEntered() {
        if isValid() {
          goToMediaListVC()
        }
        else {
          showAlert(message: "Insert Correct Email and Password")
            }
        }
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.isLoggedIn)
    }
}

    
