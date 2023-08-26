//
//  Constant.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import Foundation

class Constant {
    static var baseURL : String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    static let kAccessTokenKey = "AccessToken"
    static let kFirstNameKey = "firstName"
    static let kLastNameKey = "lastName"
    static let kPhoneKey = "phone"
    static let kImageKey = "image"
    
    static var Token: String {
        return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String ?? ""
    }
    
    static var firstName: String {
        return UserDefaults.standard.value(forKey: kFirstNameKey) as? String ?? ""
    }
    
    static var lastName: String {
        return UserDefaults.standard.value(forKey: kLastNameKey) as? String ?? ""
    }
    
    static var phone: String {
        return UserDefaults.standard.value(forKey: kPhoneKey) as? String ?? ""
    }
    
    static var image: String {
        return UserDefaults.standard.value(forKey: kImageKey) as? String ?? ""
    }
}
