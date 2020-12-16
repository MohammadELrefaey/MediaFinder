//
//  ViewController.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class RegisterationVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet var genderSwitch: UISwitch!
    @IBOutlet var SignUpBtn: UIButton!
    
    var gender: String = "Male"
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
    }
    

    func isDataEntered() -> Bool {
         if let email = emailTxtField.text, email.isEmpty == false,
            let password = passwordTxtField.text, password.isEmpty == false,
            let name = nameTxtField.text, name.isEmpty == false,
            let phone = phoneTxtField.text, phone.isEmpty == false,
            let address = addressTxtField.text, address.isEmpty == false {
            
            user = User(email: email, password: password, name: name, address: address, phone: phone, gender: gender)
            setUserDefaults(user: user)
            
            return true
        }
    
            return false
    }
    
    func setUserDefaults(user: User){
                   let encoder = JSONEncoder()
                   if let encoded = try? encoder.encode(user) {
                       UserDefaults.standard.set(encoded, forKey: "User")
                   }
               }
    
    // Validations
    func validateEmail() -> Bool {
        if  emailTxtField.text!.isValidEmail(Input: emailTxtField.text!) {
            return true
        }
        else {
            return false
        }
    }
    
    func validateName() -> Bool {
        if  nameTxtField.text!.isValidName(Input: nameTxtField.text!) {
               return true
           }
           else {
            
               return false
           }
       }
    
    func validatePassword() -> Bool {
        if passwordTxtField.text!.isValidPassword(Input: passwordTxtField.text!) {
               return true
           }
           else {
           
               return false
           }
       }
    
    func validatePhone() -> Bool {
        if  phoneTxtField.text!.isValidPhone(Input: phoneTxtField.text!) {
               return true
           }
           else {
               return false
           }
       }
    func validateAddress() -> Bool {
        if  addressTxtField.text!.isValidAddress(Input: addressTxtField.text!) {
            return true
        }
        else {
            return false
        }
    }
        
    
    func goToLoginVC() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: "loginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
//        self.present(loginVC, animated: true, completion: nil)
    }
    
    
    @IBAction func addressBtnPressed(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = sb.instantiateViewController(identifier: "MapVC") as! MapVC
        
        mapVC.delegate = self
        
        self.present(mapVC, animated: true, completion: nil)
    }
    
    
    @IBAction func genderSwitchTapped(_ sender: UISwitch) {
        if sender.isOn {
            self.gender = "Female"
        }
//        else {
//            self.gender = Male
//        }
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        guard isDataEntered() else {
            return showAlert(message: "Insert Valid data")
        }
        guard validateEmail() else {
            return showAlert(message: "Insert Valid Email")
        }
        guard validatePassword() else {
           return showAlert(message: "Insert Valid password")
        }
        guard validateName() else {
          return  showAlert(message: "Insert Valid Name")
        }
        guard validatePhone() else {
           return showAlert(message: "Insert Valid Phone")
        }
//        guard validateAddress() else {
//           return showAlert(message: "Insert Valid Address")
//        }
        goToLoginVC()
    }

}


extension RegisterationVC: SendingDataProtocol {
    func sendingData(data: String) {
        addressTxtField.text = data
    }
}
