//
//  ViewController.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import SQLite

class RegisterationVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet var genderSwitch: UISwitch!
    @IBOutlet var SignUpBtn: UIButton!
    
    //MARK:- Properties
    var gender: Gender! = .Male
    var user: User!

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavigationBar()
    }
    //MARK:- Actions
        @IBAction func addressBtnPressed(_ sender: UIButton) {
            let sb = UIStoryboard(name: Storyboard.main, bundle: nil)
            let mapVC = sb.instantiateViewController(identifier: ViewContoller.MapVC) as! MapVC
            
            mapVC.delegate = self
            
            self.present(mapVC, animated: true, completion: nil)
        }
        
        
        @IBAction func genderSwitchTapped(_ sender: UISwitch) {
            if sender.isOn {
                self.gender = .Female
            }
        }
    
        @IBAction func signUpBtnTapped(_ sender: UIButton) {
            if validateFields() {
                InserUserToDataBase()
                goToLoginVC()
            }
        }
}

//MARK:- SendingDataProtocol
extension RegisterationVC: SendingDataProtocol {
    func sendingData(data: String) {
        addressTxtField.text = data
    }
}

//MARK:- Private Methods
extension RegisterationVC {
    private func isDataEntered() -> Bool {
         if let email = emailTxtField.text, email.isEmpty == false,
            let password = passwordTxtField.text, password.isEmpty == false,
            let name = nameTxtField.text, name.isEmpty == false,
            let phone = phoneTxtField.text, phone.isEmpty == false,
            let address = addressTxtField.text, address.isEmpty == false {
            user = User(email: email, password: password, name: name, address: address, phone: phone, gender: gender)
            return true
            }
                
           return false
    }
   
    // Validations
    private func validateFields() -> Bool {
        guard isDataEntered() else {
            showAlert(message: "Insert Valid Data")
            return false
        }
        guard emailTxtField.text!.isValidEmail(Input: emailTxtField.text!) else {
            showAlert(message: "Insert Valid Email \n ex: your_email@example.com")
            return false
        }
        guard passwordTxtField.text!.isValidPassword(Input: passwordTxtField.text!) else {
            showAlert(message: "Insert Valid password \n at least 8 charcters")
           return false
        }
        guard nameTxtField.text!.isValidName(Input: nameTxtField.text!) else {
            showAlert(message: "Insert Valid Name \n Letters only")
          return false
        }
        guard phoneTxtField.text!.isValidPhone(Input: phoneTxtField.text!) else {
            showAlert(message: "Insert Valid Phone \n must be 11 number")
           return false
        }
        return true
    }
        
    
    private func goToLoginVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: ViewContoller.LoginVC) as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func CustomNavigationBar() {
        self.title = VCTitles.Registeration
        self.navigationItem.setHidesBackButton(true, animated: true)        
    }
    
    private func InserUserToDataBase() {
        SQLiteManager.shared().deleteUser()
        SQLiteManager.shared().insertUser(user: user)
        UserDefaulsManager.shared().setUserInUserDefaults(user: user)
    }
}
