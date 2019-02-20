//
//  MeReposViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class MeReposViewController: UIViewController {

    let bag = DisposeBag()
    var items = [PopularItemViewModel?]()
    let meRepoVM = MeReposViewModel()
    var page = 1

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.sp.registerCellFromNib(cls: PopularCell.self)
        view.estimatedRowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()

        self.navigationItem.title = "Repos"

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

    func fetchData() {
        meRepoVM.fetchUserRepos(page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.page == 1 {
                    self?.items.removeAll()
                    self?.tableView.headRefreshControl.endRefreshing()
                    if result.count == ig_pageSize {
                        self?.tableView.footRefreshControl.isHidden = false
                    }
                } else {
                    if result.count < ig_pageSize {
                        self?.tableView.footRefreshControl.endRefreshingAndNoLongerRefreshing(withAlertText: "no more")
                    } else {
                        self?.tableView.footRefreshControl.endRefreshing()
                    }
                }
                self?.items += result
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

extension MeReposViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(PopularCell.self, indexPath: indexPath)
        cell.bindData(vm: self.items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        let vc = IWebViewController(urlPath: item?.url)
        vc.webTitle = item?.repoName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
