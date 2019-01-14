//
//  AuthManager.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class AuthManager {

    static let share = AuthManager()

    fileprivate let token_key = "com.iGithub.token"
    fileprivate let tokenValidated_key = "com.iGithub.tokenValidated"

    var tokenValidated: Bool {
        get {
            return UserDefaults.standard.object(forKey: tokenValidated_key) as? Bool ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: tokenValidated_key)
            UserDefaults.standard.synchronize()
        }
    }

    var token: String? {
        get {
            return UserDefaults.standard.object(forKey: token_key) as? String ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: token_key)
            UserDefaults.standard.synchronize()
        }
    }

    func createToken(userName: String, password: String) {
        let hash = "\(userName):\(password)".toBase64()
        let authHash = "Basic \(hash)"
        token = authHash
    }

    func removeToken() {
        tokenValidated = false
        token = nil
    }
}
