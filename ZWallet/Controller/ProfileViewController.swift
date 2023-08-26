//
//  ProfileViewController.swift
//  ZWallet
//
//  Created by DDL11 on 16/08/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileNumber: UILabel!
    
    @IBOutlet weak var barProfile: UIView!
    @IBOutlet weak var barChangePIN: UIView!
    @IBOutlet weak var barChangePassword: UIView!
    @IBOutlet weak var barNotification: UIView!
    @IBOutlet weak var barLogout: UIView!
    
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var logoutLeadingCOnstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        setupUI()
    }
    
    func setupUI() {
        profileImage.layer.cornerRadius = 10
        profileImage.layer.masksToBounds = true
        profileImage.kf.setImage(with: URL(string: "\(Constant.baseURL)\(Constant.image)"))
        profileName.text = "\(Constant.firstName) \(Constant.lastName)"
        profileName.text = "\(Constant.firstName) \(Constant.lastName)"
        profileNumber.text = "\(Constant.phone)"
    }

}

// MARK: - Tapped
extension ProfileViewController {
    @IBAction func notificationTapped(_ sender: Any){
        let isTapped = notificationSwitch.isOn
        barProfile.backgroundColor = isTapped ? UIColor(named: "bgButton100%") : UIColor(named: "bgWhite")
        barChangePIN.backgroundColor = isTapped ? UIColor(named: "bgButton100%") : UIColor(named: "bgWhite")
        barChangePassword.backgroundColor = isTapped ? UIColor(named: "bgButton100%") : UIColor(named: "bgWhite")
        barNotification.backgroundColor = isTapped ? UIColor(named: "bgButton100%") : UIColor(named: "bgWhite")
        barLogout.backgroundColor = isTapped ? UIColor(named: "bgButton100%") : UIColor(named: "bgWhite")
        if !notificationSwitch.isOn {
            let centerBar = (barLogout.frame.width / 2) - (logoutLabel.frame.width / 2)
            logoutLeadingCOnstraint.constant = centerBar
            logoutLabel.textColor = UIColor(ciColor: .red)
        } else {
            logoutLeadingCOnstraint.constant = 20
            logoutLabel.textColor = UIColor(named: "100%")
        }
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any){
        AuthNetwork().logout { data in
            if let logoutData = data {
                let alert = UIAlertController(title: "Logout", message: logoutData.message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default) { action in
                    UserDefaults.standard.removeObject(forKey: "image")
                    UserDefaults.standard.removeObject(forKey: "firstName")
                    UserDefaults.standard.removeObject(forKey: "lastName")
                    UserDefaults.standard.removeObject(forKey: "phone")
                    UserDefaults.standard.removeObject(forKey: "AccessToken")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main")
                    
                    let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
                    window?.rootViewController = UINavigationController(rootViewController: mainViewController)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
    }
}
