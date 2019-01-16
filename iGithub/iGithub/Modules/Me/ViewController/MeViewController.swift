//
//  MeViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

/*
 {
 "avatar_url" = "https://avatars2.githubusercontent.com/u/3436190?v=4";
 bio = "Just do it!! No BB!";
 blog = "";
 collaborators = 0;
 company = "<null>";
 "created_at" = "2013-01-31T08:24:19Z";
 "disk_usage" = 95618;
 email = "imyangfm@gmail.com";
 "events_url" = "https://api.github.com/users/FMYang/events{/privacy}";
 followers = 10;
 "followers_url" = "https://api.github.com/users/FMYang/followers";
 following = 29;
 "following_url" = "https://api.github.com/users/FMYang/following{/other_user}";
 "gists_url" = "https://api.github.com/users/FMYang/gists{/gist_id}";
 "gravatar_id" = "";
 hireable = "<null>";
 "html_url" = "https://github.com/FMYang";
 id = 3436190;
 location = shenzhen;
 login = FMYang;
 name = Kawa;
 "node_id" = "MDQ6VXNlcjM0MzYxOTA=";
 "organizations_url" = "https://api.github.com/users/FMYang/orgs";
 "owned_private_repos" = 0;
 plan =     {
 collaborators = 0;
 name = free;
 "private_repos" = 10000;
 space = 976562499;
 };
 "private_gists" = 0;
 "public_gists" = 0;
 "public_repos" = 20;
 "received_events_url" = "https://api.github.com/users/FMYang/received_events";
 "repos_url" = "https://api.github.com/users/FMYang/repos";
 "site_admin" = 0;
 "starred_url" = "https://api.github.com/users/FMYang/starred{/owner}{/repo}";
 "subscriptions_url" = "https://api.github.com/users/FMYang/subscriptions";
 "total_private_repos" = 0;
 "two_factor_authentication" = 0;
 type = User;
 "updated_at" = "2019-01-03T13:37:42Z";
 url = "https://api.github.com/users/FMYang";
 }
 */

import UIKit

class MeViewController: UIViewController {

    let profileVM = ProfileViewModel()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.sp.registerHeaderFooterFromNib(cls: MeTableHeaderView.self)
        view.sp.registerHeaderFooterFromNib(cls: MeTableFooterView.self)
        view.sp.registerCellFromNib(cls: ProfileCell.self)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        layoutUI()
    }

    // MARK: - fuction
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension MeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileVM.numbersOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileVM.cellOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(ProfileCell.self, indexPath: indexPath)
        let item = profileVM.itemForRow(indexPath: indexPath)
        cell.bindData(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.sp.dequeueHeaderFooter(MeTableHeaderView.self)
            view.bindData(vm: profileVM.headerItem)
            return view
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            let height = tableView.sp.dequeueHeaderFooter(MeTableHeaderView.self).systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            return height
        } else {
            return 20
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            let height = tableView.sp.dequeueHeaderFooter(MeTableFooterView.self).systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            return height
        }
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            let view = tableView.sp.dequeueHeaderFooter(MeTableFooterView.self)
            view.delegate = self
            return view
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = profileVM.itemForRow(indexPath: indexPath)
        switch item.type {
        case .blog:
            if let blog = profileVM.user?.blog {
                let vc = IWebViewController(urlPath: blog)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            return
        }
    }
}

extension MeViewController: ProfileFooterViewDelegate {
    func logout() {
        (UIApplication.shared.delegate as? AppDelegate)?.logout()
    }
}
