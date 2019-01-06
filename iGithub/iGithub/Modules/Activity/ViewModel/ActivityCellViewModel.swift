//
//  ActivityCellModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

struct ActivityCellViewModel {
    var avatar: String?
    var title: String = ""
    var updateTime: String?
    var repoTitle: String?
    var repoDescription: String?
    var repoLangauge: String?
    var repoStar: String?
    var repoUpdateTime: String?

    init(activity: Activity?, repo: RepoDetail?) {
        self.avatar = activity?.actor?.avatar_url
        if let name = activity?.actor?.display_login, let action = activity?.payload?.action, let repo = activity?.repo?.name {
            self.title = name + " " + action + " " + repo
        }
        self.updateTime = activity?.created_at
        self.repoTitle = activity?.repo?.name
        
        // 2
        self.repoDescription = repo?.description
        self.repoLangauge = repo?.language
        self.repoStar = String(describing: repo?.stargazers_count ?? 0)
        self.repoUpdateTime = repo?.updated_at
    }
}
