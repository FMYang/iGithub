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

    init(model: Activity?) {
        self.avatar = model?.actor?.avatar_url
        if let name = model?.actor?.display_login, let action = model?.payload?.action, let repo = model?.repo?.name {
            self.title = name + " " + action + " " + repo
        }
        self.updateTime = model?.created_at
        self.repoTitle = model?.repo?.name
    }
}
