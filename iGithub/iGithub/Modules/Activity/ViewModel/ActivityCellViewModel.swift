//
//  ActivityCellModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/5.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import UIKit

struct ActivityCellViewModel {
    var avatar: String?
    var title: NSMutableAttributedString = NSMutableAttributedString(string: "")
    var updateTime: String?
    var repoName: String?
    var repoDescription: String?
    var repoLangauge: String?
    var repoStar: String = "0"
    var repoUpdateTime: String?

    init(activity: Activity?, repo: RepoDetail?) {
        // activity data
        self.avatar = activity?.actor?.avatar_url
        if let name = activity?.actor?.display_login, let action = activity?.type?.eventName, let repo = activity?.repo?.name {
            let titleText = name + " " + action + " " + repo
            let titleAttribute = NSMutableAttributedString(string: titleText)
            let nameRange = (titleText as NSString).range(of: name)
            let repoRange = (titleText as NSString).range(of: repo)
            titleAttribute.addAttributes([.foregroundColor : UIColor.red], range: nameRange)
            titleAttribute.addAttributes([.foregroundColor : UIColor.red], range: repoRange)
            self.title = titleAttribute
        }
        self.updateTime = activity?.created_at
        self.repoName = activity?.repo?.name
        
        // repo data
        self.repoDescription = repo?.description
        self.repoLangauge = repo?.language
        if let star = repo?.stargazers_count {
            if star > 1000 {
                self.repoStar = String(format: "%.1f", Double(star)/1000.0)+"k"
            } else {
                self.repoStar = String(star)
            }
        }
        self.repoUpdateTime = repo?.updated_at
    }
}
