//
//  MeViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

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
            view.delegate = self
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
            if let blog = profileVM.user?.blog, !blog.isEmpty {
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

extension MeViewController: ProfileHeaderViewDelegate {
    func gotoUserReposPage() {
        let vc = MeReposViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoFollowersPage() {
        let vc = MeFollowersViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoFollowingPage() {
        let vc = MeFollowingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
