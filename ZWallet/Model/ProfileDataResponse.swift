//
//  ProfileDataResponse.swift
//  ZWallet
//
//  Created by DDL11 on 17/08/23.
//

import Foundation

struct ProfileDataResponse: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var phone: String
    var image: String
}
