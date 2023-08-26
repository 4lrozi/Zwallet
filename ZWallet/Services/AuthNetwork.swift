//
//  AuthNetwork.swift
//  ZWallet
//
//  Created by DDL11 on 14/08/23.
//

import Foundation
import Moya

class AuthNetwork {
    
    func login(email: String, password: String, completion: @escaping (LoginDataResponse?, Error?) -> ()) {
        let provider = MoyaProvider<AuthApi>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        provider.request(.login(email: email, password: password)) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let loginResponse = try decoder.decode(LoginResponse.self, from: result.data)
                    completion(loginResponse.data, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getProfile(completion: @escaping (ProfileDataResponse?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        
        provider.request(.getProfile) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let profileResponse = try decoder.decode(ProfileResponse.self, from: result.data)
                    completion(profileResponse.data)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func register(username: String, email: String, password: String, completion: @escaping (SignUpResponse?, Error?) -> ()) {
        let provider = MoyaProvider<AuthApi>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        provider.request(.register(username: username, email: email, password: password)) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let signUpResponse = try decoder.decode(SignUpResponse.self, from: result.data)
                    completion(signUpResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func forgotPassword(email: String, password: String, completion: @escaping (ForgotPasswordResponse?, Error?) -> ()) {
        let provider = MoyaProvider<AuthApi>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        provider.request(.forgotPassword(email: email, password: password)) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let forgotPasswordResponse = try decoder.decode(ForgotPasswordResponse.self, from: result.data)
                    completion(forgotPasswordResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func logout(completion: @escaping (LogoutResponse?) -> ()) {
        let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        
        provider.request(.logout) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let logoutResponse = try decoder.decode(LogoutResponse.self, from: result.data)
                    completion(logoutResponse)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
