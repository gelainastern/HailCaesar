//
//  ViewController.swift
//  EncryptionCalculator
//
//  Created by Gelaina Stern on 1/22/17.
//  Copyright © 2017 Join The Resistance. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var number: Int?
    
    var message: String?
    
    @IBOutlet weak var dynamicTxtField: UITextView!
    @IBOutlet weak var key: UITextField!
    
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var decryptedTextField: UITextView!
    
    
    var pickerView: UIPickerView?
    
    var pickOption = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        eButton.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        eButton.layer.borderWidth = 2
        eButton.layer.cornerRadius = 7
        
        dButton.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        dButton.layer.borderWidth = 2
        dButton.layer.cornerRadius = 7
        
        pasteButton.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        pasteButton.layer.borderWidth = 2
        pasteButton.layer.cornerRadius = 7
        
        copyButton.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        copyButton.layer.borderWidth = 2
        copyButton.layer.cornerRadius = 7
        
        dynamicTxtField.layer.cornerRadius = 7
        dynamicTxtField.layer.borderWidth = 2
        dynamicTxtField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        decryptedTextField.layer.cornerRadius = 7
        decryptedTextField.layer.borderWidth = 2
        decryptedTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        
        self.hideKeyboardWhenTappedAround()
        
        
        pickerView = UIPickerView()
        
        self.key.delegate = self
        
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        
        key.inputView = pickerView
        
        pickerView?.isHidden = true
        
        
    }
    
    
    
    
    func alert() {
        let alertController = UIAlertController(title: "Not a valid number", message: "Enter a number between 1 and 25.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    


    @IBAction func eButtonTapped(_ sender: Any) {
        dismissKeyboard()
        message = dynamicTxtField.text
        guard let text = key.text, let intText = Int(text) else {
            alert()
            return
        }
        switch intText {
        case 1...25:
            decryptedTextField.text = CipherController.sharedController.encryptCaesarian(message: message, number: intText)
        default:
            alert()
        }
        
    }
    
    
    @IBAction func dButtonTapped(_ sender: Any) {
        dismissKeyboard()
        message = dynamicTxtField.text
        guard let text = key.text, let intText = Int(text) else {
            alert()
            return
        }
        switch intText {
        case 1...25:
            decryptedTextField.text = CipherController.sharedController.decryptCaesarian(message: message, number: intText)
        default:
            alert()
        }
    }
    
    
    @IBAction func pasteButtonTapped(_ sender: Any) {
        dynamicTxtField.text = ""
        if let myString = UIPasteboard.general.string {
            self.dynamicTxtField.insertText(myString)
        }
    }
    

    @IBAction func copyButtonTapped(_ sender: Any) {
        guard let text = decryptedTextField.text else { return }
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.key.text = self.pickOption[row]
        self.pickerView?.isHidden = true
        self.pickerView?.removeFromSuperview()
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView?.isHidden = false
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    

    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

