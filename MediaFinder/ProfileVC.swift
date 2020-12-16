//
//  ProfileVC.swift
//  MediaFinder
//
//  Created by Mohamed on 11/12/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet var phoneLabel: LabelBorder!
    @IBOutlet var nameLable: LabelBorder!
    @IBOutlet var addressLabel: LabelBorder!
    @IBOutlet var genderLabel: LabelBorder!
    
    var user: User!   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden = true

        self.user = getUserDefaults()
        printData()
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
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

    
    func printData() {
        nameLable.text = " " + self.user.name
        phoneLabel.text = " " + self.user.phone
        addressLabel.text = " " + self.user.address
        genderLabel.text = " " + self.user.gender
            }
    
    func goToLoginVC() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let loginVC = sb.instantiateViewController(identifier: "loginVC") as! LoginVC
    //self.present(loginVC, animated: true, completion: nil)
    self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
       goToLoginVC()
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
    }
    
}
