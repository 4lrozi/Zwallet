//
//  ViewController.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailIconTextField: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailUnderlineTextField: UIView!
    
    @IBOutlet weak var passwordIconTextField: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordUnderlineTextField: UIView!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var passwordInvalidLabel: UILabel!
    @IBOutlet weak var loginButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        setupUI()
        setupKeyboardHiding()
    }
    
    private func setupUI() {
        loginButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


// MARK: - TextField
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            if text.isEmail && passwordTextField.text?.count ?? 0 >= 3 {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                loginButton.isEnabled = true
                loginButton.backgroundColor = UIColor(named: "Primary")
                loginButton.tintColor = UIColor(ciColor: .white)
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(named: "bgButton")
                loginButton.tintColor = UIColor(named: "tintButton")
            }
        case passwordTextField:
            if emailTextField.text?.isEmail ?? false && text.count >= 3 {
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                loginButton.isEnabled = true
                loginButton.backgroundColor = UIColor(named: "Primary")
                loginButton.tintColor = UIColor(ciColor: .white)
            } else {
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(named: "bgButton")
                loginButton.tintColor = UIColor(named: "tintButton")
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
        case passwordTextField:
                passwordIconTextField.tintColor = UIColor(named: "Primary")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "Primary")
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
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(named: "bgButton")
                loginButton.tintColor = UIColor(named: "tintButton")
            } else {
                emailIconTextField.tintColor = UIColor(named: "Primary")
                emailUnderlineTextField.backgroundColor = UIColor(named: "Primary")
            }
        case passwordTextField:
            if passwordTextField.text == "" {
                passwordIconTextField.tintColor = UIColor(named: "60%")
                passwordUnderlineTextField.backgroundColor = UIColor(named: "60%")
                loginButton.isEnabled = false
                loginButton.backgroundColor = UIColor(named: "bgButton")
                loginButton.tintColor = UIColor(named: "tintButton")
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
extension ViewController {
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        let isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        showPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.tintColor = isSecureTextEntry ? UIColor(named: "60%") : UIColor(named: "Primary")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        AuthNetwork().login(email: emailTextField.text!, password: passwordTextField.text!) { data, error in
            if let loginData = data {
                UserDefaults.standard.set(loginData.token, forKey: Constant.kAccessTokenKey)
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeView")
                
                let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
                window?.rootViewController = UINavigationController(rootViewController: homeViewController)
                
            } else {
                self.passwordInvalidLabel.isHidden = false
                self.emailIconTextField.tintColor = UIColor(ciColor: .red)
                self.emailUnderlineTextField.backgroundColor = UIColor(ciColor: .red)
                self.passwordIconTextField.tintColor = UIColor(ciColor: .red)
                self.passwordUnderlineTextField.backgroundColor = UIColor(ciColor: .red)
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpView") as! SignUpViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func forgotButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordView") as! ForgotPasswordViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
