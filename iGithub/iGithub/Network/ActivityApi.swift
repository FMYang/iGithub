//
//  ActivityApi.swift
//  iGithub
//
//  Created by 杨方明 on 2019/1/4.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

enum ActivityApi {
    case publicEvent(userName: String)
}

extension ActivityApi: GithubTarget {
    var params: [String : Any]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .publicEvent(let userName):
            return "users/\(userName)/received_events/public"
        }
    }
}
