//
//  FollowingViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class FollowingViewModel {
    func fetchFollowers(page: Int) -> Observable<[String]> {
        return Network.request(MeApi.listFollowing(userName: UserManager.share.userName, page: page))
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

    func fetchFollowingUsers(page: Int) -> Observable<[FollowUserViewModel?]> {
        let logins = self.fetchFollowers(page: page)

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
