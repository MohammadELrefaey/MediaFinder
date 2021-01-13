//
//  labelBorder.swift
//  MediaFinder
//
//  Created by Mohamed on 11/11/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
@IBDesignable

class CustomTextField: UITextField {

    override func prepareForInterfaceBuilder() {
        customizeView()
    }
        
    override func awakeFromNib() {
        customizeView()
    }
}
        
    //MARK:- Private Method
extension CustomTextField {
    func customizeView() {
            layer.cornerRadius = 5.0
            backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
}

