//
//  FollowUserViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

struct FollowUserViewModel {
    var avatar: String?
    var login: String?
    var name: String?
    var description: String?
    var location: String?

    init(user: User?) {
        avatar = user?.avatar_url
        login = user?.login
        name = user?.name
        description = user?.bio
        location = user?.location
    }
}
