//
//  AuthApi.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import Foundation
import Moya

enum AuthApi {
    case login(email: String, password: String)
    case getProfile
    case register(username: String, email: String, password: String)
    case forgotPassword(email: String, password: String)
    case logout
}

extension AuthApi: TargetType {
    var baseURL: URL {
        return URL(string: Constant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .getProfile:
            return "/user/myProfile"
        case .register:
            return "/auth/signup"
        case .forgotPassword:
            return "/auth/reset"
        case .logout:
            return "/auth/logout/\(Constant.Token)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .register:
            return .post
        case .getProfile:
            return .get
        case .forgotPassword:
            return .patch
        case .logout:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        case .getProfile, .logout:
            return .requestPlain
        case .register(let username, let email, let password):
            return .requestParameters(parameters: ["username": username, "email": email, "password": password], encoding: URLEncoding.default)
        case .forgotPassword(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .register, .forgotPassword:
            return nil
        case .getProfile, .logout:
            return ["Authorization": "Bearer \(Constant.Token)"]
        }
    }
    
}
