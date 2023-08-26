//
//  SignUpViewController.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userIconTextField: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userUnderlineTextField: UIView!
    
    @IBOutlet weak var emailIconTextField: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailUnderlineTextField: UIView!
    
    @IBOutlet weak var passwordIconTextField: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordUnderlineTextField: UIView!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var SignUpButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        setupUI()
        setupKeyboardHiding()
    }
    
    private func setupUI() {
        SignUpButton.isEnabled = false
        userTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

// MARK: - TextField
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case userTextField:
            if text.count >= 3 && emailTextField.text?.isEmail ?? false && passwordTextField.text?.count ?? 0 >= 3 {
                userIconTextField.tintColor = UIColor(named: "Primary")
                userUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = true
                SignUpButton.backgroundColor = UIColor(named: "Primary")
                SignUpButton.tintColor = UIColor(ciColor: .white)
            } else {
                userIconTextField.tintColor = UIColor(named: "Primary")
                userUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
            }
        case emailTextField:
            if userTextField.text?.count ?? 0 >= 3 && text.isEmail && passwordTextField.text?.count ?? 0 >= 3 {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = true
                SignUpButton.backgroundColor = UIColor(named: "Primary")
                SignUpButton.tintColor = UIColor(ciColor: .white)
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
            }
        case passwordTextField:
            if userTextField.text?.count ?? 0 >= 3 && emailTextField.text?.isEmail ?? false && text.count >= 3 {
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = true
                SignUpButton.backgroundColor = UIColor(named: "Primary")
                SignUpButton.tintColor = UIColor(ciColor: .white)
            } else {
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
            }
        default:
            break
        }
        
        
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case userTextField:
                userIconTextField.tintColor = UIColor(named: "Primary")
                userUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        case emailTextField:
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        case passwordTextField:
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case userTextField:
            if userTextField.text == "" {
                userIconTextField.tintColor = UIColor(named: "60%")
                userUnderlineTextField.backgroundColor = UIColor(named: "60%")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
            } else {
                userIconTextField.tintColor = UIColor(named: "Primary")
                userUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        case emailTextField:
            if emailTextField.text == "" {
                emailIconTextField.tintColor = UIColor(named: "60%")
                emailUnderlineTextField.backgroundColor = UIColor(named: "60%")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        case passwordTextField:
            if passwordTextField.text == "" {
                passwordIconTextField.tintColor = UIColor(named: "60%")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "60%")
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = UIColor(named: "bgButton")
                SignUpButton.tintColor = UIColor(named: "tintButton")
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
extension SignUpViewController {
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        let isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        showPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.tintColor = isSecureTextEntry ? UIColor(named: "60%") : UIColor(named: "Primary")
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        AuthNetwork().register(username: userTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { data, error in
            if let signUpResponse = data {
                let alert = UIAlertController(title: "Register", message: signUpResponse.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    let storyboard = UIStoryboard(name: "OTP", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "OTPView") as! OTPViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                }))
                self.present(alert, animated: true)
            } else {
                let errorAlert = UIAlertController(title: "Register", message: "Error", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            }
        }
    }
    
    @IBAction func loginUpButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
