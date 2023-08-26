//
//  HomeViewController.swift
//  ZWallet
//
//  Created by DDL11 on 15/08/23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var balanceText: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
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
        topView.layer.cornerRadius = 16
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AuthNetwork().getProfile { data in
            if let profileData = data {
                UserDefaults.standard.set(profileData.image, forKey: Constant.kImageKey)
                UserDefaults.standard.set(profileData.firstname, forKey: Constant.kFirstNameKey)
                UserDefaults.standard.set(profileData.lastname, forKey: Constant.kLastNameKey)
                UserDefaults.standard.set(profileData.phone, forKey: Constant.kPhoneKey)
                self.profileImage.kf.setImage(with: URL(string: "\(Constant.baseURL)\(Constant.image)"))
            } else {
                print("Error")
            }
        }
    }

    @IBAction func testButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileView")
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
