//
//  MeViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.sp.registerHeaderFooterFromNib(cls: MeTableHeaderView.self)
        view.sp.registerCell(cls: UITableViewCell.self)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(UITableViewCell.self, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.sp.dequeueHeaderFooter(MeTableHeaderView.self)
        view.bindData()
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sp.dequeueHeaderFooter(MeTableHeaderView.self).systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
}
