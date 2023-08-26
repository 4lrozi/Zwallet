//
//  LoginResponse.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import Foundation

struct LoginResponse: Codable {
    var status: Int
    var message: String
    var data: LoginDataResponse
}
