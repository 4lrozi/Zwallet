//
//  ForgotPasswordViewController.swift
//  ZWallet
//
//  Created by DDL11 on 15/08/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailIconTextField: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailUnderlineTextField: UIView!
    
    @IBOutlet weak var confirmButton: CustomButton!
    
    var emailReset: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        emailTextField.delegate = self
    }

}

// MARK: - TextField
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            if text.isEmail {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                confirmButton.isEnabled = true
                confirmButton.backgroundColor = UIColor(named: "Primary")
                confirmButton.tintColor = UIColor(ciColor: .white)
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                confirmButton.isEnabled = false
                confirmButton.backgroundColor = UIColor(named: "bgButton")
                confirmButton.tintColor = UIColor(named: "tintButton")
            }
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case emailTextField:
            if emailTextField.text == "" {
                emailIconTextField.tintColor = UIColor(named: "60%")
                emailUnderlineTextField.backgroundColor = UIColor(named: "60%")
                confirmButton.isEnabled = false
                confirmButton.backgroundColor = UIColor(named: "bgButton")
                confirmButton.tintColor = UIColor(named: "tintButton")
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        default:
            break
        }
    }
}

// MARK: - Tapped
extension ForgotPasswordViewController {
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ForgotNewPassword", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotNewPasswordView") as? ForgotNewPasswordViewController
        
        viewController?.email = (self.emailTextField.text)!
        
        navigationController?.pushViewController(viewController!, animated: true)
    }
}

