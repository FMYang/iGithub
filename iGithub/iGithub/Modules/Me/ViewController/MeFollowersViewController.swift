//
//  MeFollowersViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class MeFollowersViewController: UIViewController {

    let bag = DisposeBag()
    let viewModel = FollowersViewModel()
    var items = [FollowUserViewModel?]()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.sp.registerCellFromNib(cls: FollowCell.self)
        view.estimatedRowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Followers"

        layoutUI()

        self.tableView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            self?.fetchData()
        })

        self.tableView.headRefreshControl.beginRefreshing()
    }
    
    // MARK: - function
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - network
    func fetchData() {
        viewModel.fetchFollowerUsers()
            .subscribe(onNext: { [weak self] (vms) in
                print(vms)
                self?.items = vms
                self?.tableView.reloadData()
                self?.tableView.headRefreshControl.endRefreshing()
            }, onError: { [weak self] (error) in
                print(error)
                self?.tableView.headRefreshControl.endRefreshing()
            })
            .disposed(by: bag)
    }
}

extension MeFollowersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(FollowCell.self, indexPath: indexPath)
        cell.bindData(model: self.items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = self.items[indexPath.row]
//        let vc = IWebViewController(urlPath: item?.url)
//        vc.webTitle = item?.repoName
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
