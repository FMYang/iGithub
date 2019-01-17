//
//  ProfileProtocol.swift
//  iGithub
//
//  Created by yfm on 2019/1/16.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

protocol ProfileHeaderViewDelegate: class {
    func gotoUserReposPage()
    func gotoFollowersPage()
    func gotoFollowingPage()
}

protocol ProfileFooterViewDelegate: class {
    func logout()
}
