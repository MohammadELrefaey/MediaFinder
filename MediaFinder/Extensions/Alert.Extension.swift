//
//  Alarm.swift
//  MediaFinder
//
//  Created by Mohamed on 11/18/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
