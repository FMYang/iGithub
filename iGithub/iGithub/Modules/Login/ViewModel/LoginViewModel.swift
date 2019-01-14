//
//  LoginViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class LoginViewModel {
    func fetchUser() -> Observable<User?> {
        return Network.request(AuthApi.profile)
            .asObservable()
            .mapObject(type: User.self)
    }
}
