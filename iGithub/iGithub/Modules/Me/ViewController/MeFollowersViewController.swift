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
    var page = 1

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

        addRefresh()
    }
    
    // MARK: - function
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func addRefresh() {
        self.tableView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            self?.page = 1
            self?.fetchData()
        })

        self.tableView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            self?.fetchData()
        })

        self.tableView.headRefreshControl.beginRefreshing()

        self.tableView.footRefreshControl.isHidden = true
    }
    

    // MARK: - network
    func fetchData() {
        viewModel.fetchFollowerUsers(page: page)
            .subscribe(onNext: { [weak self] (viewModels) in
                if self?.page == 1 {
                    self?.items.removeAll()
                    self?.tableView.headRefreshControl.endRefreshing()
                    if viewModels.count == ig_pageSize {
                        self?.tableView.footRefreshControl.isHidden = false
                    }
                } else {
                    if viewModels.count < ig_pageSize {
                        self?.tableView.footRefreshControl.endRefreshingAndNoLongerRefreshing(withAlertText: "no more")
                    } else {
                        self?.tableView.footRefreshControl.endRefreshing()
                    }
                }
                self?.items += viewModels
                self?.tableView.reloadData()

                self?.page += 1
            }, onError: { [weak self] (error) in
                print(error)
                self?.tableView.headRefreshControl.endRefreshing()
                self?.tableView.footRefreshControl.endRefreshing()
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

    }
}
