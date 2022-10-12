//
//  TrendingRepo.swift
//  iGithub
//
//  Created by yfm on 2019/1/11.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

struct TrendingRepo: HandyJSON {
    var username: String?
    var repositoryName: String?
    var url: String?
    var description: String?
    var language: String?
    var languageColor: String?
    var totalStars: Int?
    var forks: Int?
    var starsSince: Int?
    var builtBy: [RepoUser]?
}

struct RepoUser: HandyJSON {
    var username: String?
    var url: String?
    var avatar: String?
}
