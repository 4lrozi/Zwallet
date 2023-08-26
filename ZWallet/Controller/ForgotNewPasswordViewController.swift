//
//  ForgotNewPasswordViewController.swift
//  ZWallet
//
//  Created by DDL11 on 15/08/23.
//

import UIKit

class ForgotNewPasswordViewController: UIViewController {

    @IBOutlet weak var passwordIconTextField: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordUnderlineTextField: UIView!
    
    @IBOutlet weak var newPasswordIconTextField: UIImageView!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordUnderlineTextField: UIView!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showNewPasswordButton: UIButton!
    
    @IBOutlet weak var resetButton: CustomButton!
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        passwordTextField.delegate = self
        newPasswordTextField.delegate = self
    }
    
}

// MARK: - TextField
extension ForgotNewPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case newPasswordTextField:
            if text == passwordTextField.text {
                newPasswordIconTextField.tintColor = UIColor(named: "Primary")
                newPasswordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                resetButton.isEnabled = true
                resetButton.backgroundColor = UIColor(named: "Primary")
                resetButton.tintColor = UIColor(ciColor: .white)
            } else {
                newPasswordIconTextField.tintColor = UIColor(ciColor: .red)
                newPasswordUnderlineTextField.backgroundColor = UIColor(ciColor: .red)
                resetButton.isEnabled = false
                resetButton.backgroundColor = UIColor(named: "bgButton")
                resetButton.tintColor = UIColor(named: "tintButton")
            }
        default:
            break
        }
        
        
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case newPasswordTextField:
                newPasswordIconTextField.tintColor = UIColor(named: "Primary")
                newPasswordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        case passwordTextField:
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case textField:
            if newPasswordTextField.text == "" {
                newPasswordIconTextField.tintColor = UIColor(named: "60%")
                newPasswordUnderlineTextField.backgroundColor = UIColor(named: "60%")
                resetButton.isEnabled = false
                resetButton.backgroundColor = UIColor(named: "bgButton")
                resetButton.tintColor = UIColor(named: "tintButton")
            } else {
                newPasswordIconTextField.tintColor = UIColor(named: "Primary")
                newPasswordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        case passwordTextField:
            if passwordTextField.text == "" {
                passwordIconTextField.tintColor = UIColor(named: "60%")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "60%")
                resetButton.isEnabled = false
                resetButton.backgroundColor = UIColor(named: "bgButton")
                resetButton.tintColor = UIColor(named: "tintButton")
            } else {
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        default:
            break
        }
    }
}

// MARK: - Tapped
extension ForgotNewPasswordViewController {
    @IBAction func showPasswordButtonTapped(_ sender: Any){
        let isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        showPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.tintColor = isSecureTextEntry ? UIColor(named: "60%") : UIColor(named: "Primary")
    }
    
    @IBAction func showNewPasswordButtonTapped(_ sender: Any){
        let isSecureTextEntry2 = !newPasswordTextField.isSecureTextEntry
        newPasswordTextField.isSecureTextEntry = isSecureTextEntry2
        showNewPasswordButton.setImage(isSecureTextEntry2 ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        showNewPasswordButton.tintColor = isSecureTextEntry2 ? UIColor(named: "60%") : UIColor(named: "Primary")
    }
    
    @IBAction func resetButtonTapped(_ sender: Any){
        AuthNetwork().forgotPassword(email: email, password: passwordTextField.text ?? "") { data, error in
            if let forgotPasswordResponse = data {
                let alert = UIAlertController(title: "Forgot Password", message: forgotPasswordResponse.message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { action in
                    self.navigationController?.popToRootViewController(animated: true)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
            } else {
                let errorAlert = UIAlertController(title: "Forgot Password", message: "Error", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            }
        }
        
    }
}
