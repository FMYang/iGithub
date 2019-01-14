//
//  UserManager.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class UserManager {

    static let share = UserManager()

    fileprivate let user_key = "com.iGithub.user"

    var user: User? {
        get {
            let userJsonString = UserDefaults.standard.object(forKey: user_key) as? String
            return User.deserialize(from: userJsonString)
        }
        set {
            let jsonString = newValue?.toJSONString()
            UserDefaults.standard.setValue(jsonString, forKey: user_key)
            AuthManager.share.tokenValidated = true
        }
    }

    func remove() {
        user = nil
        AuthManager.share.removeToken()
    }
}
