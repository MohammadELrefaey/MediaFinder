//
//  Etensions.swift
//  MediaFinder
//
//  Created by Mohamed on 11/18/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail(Input:String) -> Bool {
    let RegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let inputPred = NSPredicate(format:"SELF MATCHES %@", RegEx)
    return inputPred.evaluate(with: self)
    }
    
    func isValidPassword(Input:String) -> Bool {
        let RegEx = "[A-Z0-9a-z._%+-]\\w{7,}"
        let inputPred = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return inputPred.evaluate(with: self)
    }
    
    func isValidName(Input:String) -> Bool {
        let RegEx = "^(?!\\P{L})[\\p{L}'\\s]{0,20}$"
        //"[a-zA-Z\\s]\\w{2,24}"
        let inputPred = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return inputPred.evaluate(with: self)
    }
    
    func isValidAddress(Input:String) -> Bool {
    let RegEx = "[a-zA-Z0-9//_\\,]\\w{2,24}"
    let inputPred = NSPredicate(format:"SELF MATCHES %@", RegEx)
    return inputPred.evaluate(with: self)
    }
    
    func isValidPhone(Input:String) -> Bool {
    let RegEx = "[0-9]{11,11}"
    let inputPred = NSPredicate(format:"SELF MATCHES %@", RegEx)
    return inputPred.evaluate(with: self)
    }
}

