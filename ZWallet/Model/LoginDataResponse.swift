//
//  LoginDataResponse.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import Foundation

struct LoginDataResponse: Codable {
    var id: Int
    var email: String
    var token: String
}
