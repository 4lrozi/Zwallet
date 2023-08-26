//
//  OTPViewController.swift
//  ZWallet
//
//  Created by DDL11 on 15/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    @IBOutlet weak var fifthTextField: UITextField!
    @IBOutlet weak var sixthTextField: UITextField!
    
    @IBOutlet weak var confirmButton: CustomButton!
    var otpText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        firstTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        thirdTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        fourthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        fifthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        sixthTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        firstTextField.becomeFirstResponder()
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        fourthTextField.delegate = self
        fifthTextField.delegate = self
        sixthTextField.delegate = self
        
        confirmButton.isEnabled = false
    }
    
}

// MARK: - TextField
extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case firstTextField:
            if text.count <= 1 {
                return true
            }
        case secondTextField:
            if text.count <= 1 {
                return true
            }
        case thirdTextField:
            if text.count <= 1 {
                return true
            }
        case fourthTextField:
            if text.count <= 1 {
                return true
            }
        case fifthTextField:
            if text.count <= 1 {
                return true
            }
        case sixthTextField:
            if text.count <= 1 {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validateOTP()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateOTP()
    }
    
    func validateOTP() {
        otpText = "\(self.firstTextField.text ?? "")\(self.secondTextField.text ?? "")\(self.thirdTextField.text ?? "")\(self.fourthTextField.text ?? "")\(self.fifthTextField.text ?? "")\(self.sixthTextField.text ?? "")"
        if firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "" && fourthTextField.text != "" && fifthTextField.text != "" && sixthTextField.text != "" {
            confirmButton.tintColor = UIColor(ciColor: .white)
            confirmButton.backgroundColor = UIColor(named: "Primary")
            confirmButton.isEnabled = true
        } else {
            confirmButton.tintColor = UIColor(named: "tintButton")
            confirmButton.backgroundColor = UIColor(named: "bgButton")
            confirmButton.isEnabled = false
        }
    }
}

// MARK: - Interaction
extension OTPViewController {
    
    //When changed value in textField
        @objc func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if  text?.count == 1 {
                switch textField{
                case firstTextField:
                    secondTextField.becomeFirstResponder()
                case secondTextField:
                    thirdTextField.becomeFirstResponder()
                case thirdTextField:
                    fourthTextField.becomeFirstResponder()
                case fourthTextField:
                    fifthTextField.becomeFirstResponder()
                case fifthTextField:
                    sixthTextField.becomeFirstResponder()
                case sixthTextField:
                    sixthTextField.resignFirstResponder()
                    self.view.endEditing(true)
                default:
                    break
                }
            }
            if  text?.count == 0 {
                switch textField{
                case firstTextField:
                    firstTextField.becomeFirstResponder()
                case secondTextField:
                    firstTextField.becomeFirstResponder()
                case thirdTextField:
                    secondTextField.becomeFirstResponder()
                case fourthTextField:
                    thirdTextField.becomeFirstResponder()
                case fifthTextField:
                    fourthTextField.becomeFirstResponder()
                case sixthTextField:
                    fifthTextField.becomeFirstResponder()
                default:
                    break
                }
            }
            else {
            }
        }
    
    @IBAction func loginUpButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
