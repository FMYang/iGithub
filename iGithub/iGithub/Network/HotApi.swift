//
//  HotApi.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Moya

enum HotApi {
    case searchPopular(q: String, sort: String, page: Int)
}

extension HotApi: GithubTarget {
    var params: [String : Any]? {
        switch self {
        case let .searchPopular(q, sort, page):
            return ["q": "stars:>1 language:\(q)",
                    "sort": sort,
                    "page": page]
        }
    }

    var path: String {
        switch self {
        case .searchPopular(_):
            return "search/repositories"
        }
    }
}
