//
//  ProfileItem.swift
//  iGithub
//
//  Created by yfm on 2019/1/16.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

enum ProfileItemType {
    case email
    case blog
    case events
    case issues
    case setting
    case none
}

struct ProfileItem {
    var icon: String?
    var text: String?
    var detailText: String?
    var enabled: Bool = true
    var type: ProfileItemType = .none
}

struct ProfileHeaderItem {
    var avatar: String?
    var name: String?
    var bio: String?
    var create_at: String?
    var location: String?
    var repos: String?
    var followers: String?
    var following: String?

    init(user: User) {
        avatar = user.avatar_url
        name = user.name
        bio = user.bio
        create_at = "Create at " + (user.created_at?.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")?.toString(dateFormat: "yyyy-MM-dd HH:mm:ss") ?? "")
        location = user.location

        if let public_repos = user.public_repos {
            if public_repos > 1000 {
                repos = String(format: "%.1f", Double(public_repos)/1000.0)+"k"
            } else {
                repos = String(public_repos)
            }
        }

        if let _followers = user.followers {
            if _followers > 1000 {
                followers = String(format: "%.1f", Double(_followers)/1000.0)+"k"
            } else {
                followers = String(_followers)
            }
        }

        if let _following = user.following {
            if _following > 1000 {
                following = String(format: "%.1f", Double(_following)/1000.0)+"k"
            } else {
                following = String(_following)
            }
        }

    }
}
