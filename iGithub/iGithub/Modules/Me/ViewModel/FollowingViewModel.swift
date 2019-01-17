//
//  FollowingViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class FollowingViewModel {
    func fetchFollowers() -> Observable<[String]> {
        return Network.request(MeApi.listFollowing(userName: "FMYang", page: 1))
            .asObservable()
            .mapArray(type: FollowUser.self)
            .flatMap { (list) -> Observable<[String]> in
                var logins = list.map { (user) -> String in
                    if let _user = user, let login = _user.login {
                        return login
                    }
                    return ""
                }
                logins = logins.filter { return !$0.isEmpty }
                return Observable.from(optional: logins)
        }
    }

    func fetchFollowingUsers() -> Observable<[FollowUserViewModel?]> {
        let logins = self.fetchFollowers()

        return logins.flatMap { (logins) -> Observable<String> in
            return Observable.from(logins)
            }
            .flatMap { (login) -> Observable<User?> in
                return Network.request(MeApi.user(userName: login))
                    .asObservable()
                    .mapObject(type: User.self)
            }
            .toArray()
            .flatMap { (users) -> Observable<[FollowUserViewModel?]> in
                let vms = users.map({ (user) -> FollowUserViewModel in
                    return FollowUserViewModel(user: user)
                })
                return Observable.from(optional: vms)
        }
    }
}
