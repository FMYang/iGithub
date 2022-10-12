//
//  TrendingCellViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/11.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class TrendingCellViewModel {
    var author: String?
    var name: String?
    var url: String?
    var description: String?
    var language: String?
    var languageColor: String?
    var stars: String?
    var forks: String?
    var currentPeriodStars: Int?
    var builtBy: [RepoUser]?
    
    init(model: TrendingRepo?) {
        self.author = model?.username
        self.name = model?.repositoryName
        self.url = model?.url
        self.description = model?.description
        self.language = model?.language
        self.languageColor = model?.languageColor
        self.currentPeriodStars = model?.starsSince
        self.builtBy = model?.builtBy

        if let starCount = model?.totalStars {
            if starCount > 1000 {
                self.stars = String(format: "%.1f", Double(starCount)/1000.0)+"k"
            } else {
                self.stars = String(starCount)
            }
        }

        if let forkCount = model?.forks {
            if forkCount > 1000 {
                self.forks = String(format: "%.1f", Double(forkCount)/1000.0)+"k"
            } else {
                self.forks = String(forkCount)
            }
        }
    }
}
