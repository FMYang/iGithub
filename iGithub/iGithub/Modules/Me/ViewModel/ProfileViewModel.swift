//
//  ProfileViewModel.swift
//  iGithub
//
//  Created by yfm on 2019/1/16.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

class ProfileViewModel {

    var headerItem: ProfileHeaderItem?
    var profileItems = [[ProfileItem]]()
    var user: User?

    init() {
        guard let _user = UserManager.share.user else { return }
        user = _user
        buildDataSource(user: _user)
    }

    func buildDataSource(user: User) {

        // build header data
        headerItem = ProfileHeaderItem(user: user)

        // build cell data
        var section_0_data = [ProfileItem]()
        var section_1_data = [ProfileItem]()
        if let email = user.email, !email.isEmpty {
            let emailItem = ProfileItem(icon: "setting-email",
                                        text: "Email",
                                        detailText: email,
                                        enabled: false,
                                        type: .email)
            section_0_data.append(emailItem)
        }

        if let blog = user.blog, !blog.isEmpty {
            let blogItem = ProfileItem(icon: "setting-blog",
                                       text: "Blog",
                                       detailText: blog,
                                       enabled: true,
                                       type: .blog)
            section_0_data.append(blogItem)
        }

        let eventItem = ProfileItem(icon: "setting-event",
                                    text: "Events",
                                    detailText: "",
                                    enabled: true,
                                    type: .events)

        let issueItem = ProfileItem(icon: "setting-issue",
                                    text: "Issues",
                                    detailText: "",
                                    enabled: true,
                                    type: .issues)
        section_0_data.append(eventItem)
        section_0_data.append(issueItem)

        let settingItem = ProfileItem(icon: "setting-icon",
                                      text: "Setting",
                                      detailText: "",
                                      enabled: true,
                                      type: .setting)
        section_1_data.append(settingItem)

        profileItems.append(section_0_data)
        profileItems.append(section_1_data)
    }

    //
    func numbersOfSection() -> Int {
        return 2
    }

    func cellOfRows(section: Int) -> Int {
        return profileItems[section].count
    }

    func itemForRow(indexPath: IndexPath) -> ProfileItem {
        return profileItems[indexPath.section][indexPath.row]
    }
}

