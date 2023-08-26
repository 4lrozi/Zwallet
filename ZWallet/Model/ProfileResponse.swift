//
//  ProfileResponse.swift
//  ZWallet
//
//  Created by DDL11 on 15/08/23.
//

import Foundation

struct ProfileResponse: Codable {
    var status: Int
    var message: String
    var data: ProfileDataResponse
}
