//
//  ActivityViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import FDFullscreenPopGesture

class ActivityViewController: UIViewController {

    let bag = DisposeBag()
    let activityVM = ActivityViewModel()
    var listModel = [ActivityCellViewModel?]()
    var page = 1

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.sp.registerCellFromNib(cls: ActivityListCell.self)
        view.estimatedRowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true

        layoutUI()

        addRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - fuction
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
    }

    // MARK: - network
    func fetchData() {
        activityVM.fetchActivityAndRepo(page: page).subscribe(onNext: { [weak self] (cellModels) in
            if self?.page == 1 {
                self?.listModel.removeAll()
            }
            self?.listModel += cellModels
            self?.tableView.reloadData()
            self?.tableView.headRefreshControl.endRefreshing()
            self?.tableView.footRefreshControl.endRefreshing()
            self?.page += 1
        }, onError: { [weak self] (error) in
            print(error.localizedDescription)
            self?.tableView.headRefreshControl.endRefreshing()
            self?.tableView.footRefreshControl.endRefreshing()
        })
        .disposed(by: bag)
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(ActivityListCell.self, indexPath: indexPath)
        cell.bindData(vm: self.listModel[indexPath.row])
        if(indexPath.row == self.listModel.count - 1) {
            cell.lineView.isHidden = true
        } else {
            cell.lineView.isHidden = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.listModel[indexPath.row]
        let vc = IWebViewController(urlPath: item?.url)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
