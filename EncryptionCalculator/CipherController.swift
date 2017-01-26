//
//  CipherController.swift
//  DecryptionCalculator
//
//  Created by Gelaina Stern on 10/26/16.
//  Copyright © 2016 Old Republic. All rights reserved.
//

import Foundation

class CipherController {
    
    static let sharedController = CipherController()
    
    let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

    var caesarianAlphabet: [String] = []
    
    
    
    
    func encryptCaesarian(message: String?, number: Int?) -> String {
        caesarianAlphabet.removeAll()
        guard let num = number else { return "" }
        for (index, value) in alphabet.enumerated() {
            if index >= num {
                caesarianAlphabet.append(value)
            }
        }
        for (index, value) in alphabet.enumerated() {
            if index < num {
                caesarianAlphabet.append(value)
            }
        }
        
        let messageLowerCase = message?.lowercased()
        let chars = messageLowerCase?.characters.map { String($0) }
        guard let charsEnumerated = chars?.enumerated() else { return "" }
        var result = ""
        for (index, value) in charsEnumerated {
            if alphabet.contains(value) {
                if let newIndex = alphabet.index(of: value) {
                    result = result + caesarianAlphabet[newIndex]
                }
            } else {
                result = result + value
            }
        }
        return result
    }
    
    


    func decryptCaesarian(message: String?, number: Int) -> String {
        caesarianAlphabet.removeAll()
        for (index, value) in alphabet.enumerated() {
            if index >= number {
                caesarianAlphabet.append(value)
            }
        }
        for (index, value) in alphabet.enumerated() {
            if index < number {
                caesarianAlphabet.append(value)
            }
        }
        
        let messageLowerCase = message?.lowercased()
        let chars = messageLowerCase?.characters.map { String($0) }
        guard let charsEnumerated = chars?.enumerated() else { return "" }
        var result = ""
        for (index, value) in charsEnumerated {
            if alphabet.contains(value) {
                if let newIndex = caesarianAlphabet.index(of: value) {
                    result = result + alphabet[newIndex]
                }
            } else {
                result = result + value
            }
        }
        return result
    }

    
    
}
