//
//  labelBorder.swift
//  MediaFinder
//
//  Created by Mohamed on 11/11/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

    import UIKit
    @IBDesignable
    class CurrencyTextField: UITextField {

        
        override func prepareForInterfaceBuilder() {
            customizeView()

        }
        
        override func awakeFromNib() {
           customizeView()
        }
        
        func customizeView() {
            layer.cornerRadius = 5.0
            backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            textAlignment = .center
        }
    }

