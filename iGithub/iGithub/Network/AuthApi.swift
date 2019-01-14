//
//  AuthApi.swift
//  iGithub
//
//  Created by yfm on 2019/1/11.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

enum AuthApi {
    case profile
}

extension AuthApi: GithubTarget {

    var params: [String : Any]? {
        return [:]
    }

    var path: String {
        switch self {
        case .profile:
            return "user"
        }
    }
}
