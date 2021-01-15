//
//  LabelBorder.swift
//  MediaFinder
//
//  Created by Mohamed on 11/27/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit

class LabelBorder: UILabel {
    override func awakeFromNib() {
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = 5.0
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}
