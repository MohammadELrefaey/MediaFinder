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
        self.user = getUserDefaults()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    func getUserDefaults() -> User? {
        if let savedUser = UserDefaults.standard.object(forKey: "User") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                return loadedUser
            }
        }
        return nil
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
    let mediaListVC = sb.instantiateViewController(identifier: "mediaListVC") as! MediaListVC
    self.navigationController?.pushViewController(mediaListVC, animated: true)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let registerationVC = sb.instantiateViewController(identifier: "registerationVC") as! RegisterationVC
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
    }
}

    
