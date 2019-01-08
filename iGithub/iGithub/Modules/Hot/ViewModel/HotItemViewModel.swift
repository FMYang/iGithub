//
//  HotItemViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

struct HotItemViewModel {
    var repoName: String?
    var repoDescription: String?
    var licenceName: String?
    var updateTime: String?
    var language: String?
    var star: String?
    
    init(item: RepoItem) {
        self.repoName = item.full_Name
        self.repoDescription = item.description
        self.licenceName = item.license?.name
        self.language = item.language
        self.updateTime = item.updated_at
        if let starCount = item.stargazers_count {
            if starCount > 1000 {
                self.star = String(format: "%.1f", Double(starCount)/1000.0)+"k"
            } else {
                self.star = String(starCount)
            }
        }
    }
}
