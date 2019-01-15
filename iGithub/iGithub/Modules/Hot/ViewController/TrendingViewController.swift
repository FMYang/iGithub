//
//  TrendingViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import KafkaRefresh

class TrendingViewController: UIViewController {

    let bag = DisposeBag()
    let viewModel = TrendingViewModel()
    var cellVMs = [TrendingCellViewModel?]()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.sp.registerCellFromNib(cls: TrendingCell.self)
        view.estimatedRowHeight = 150
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        viewModel.fetchTrending()
            .subscribe(onNext: { [weak self] (result) in
                self?.cellVMs = result
                self?.tableView.reloadData()
                self?.tableView.headRefreshControl.endRefreshing()
            }, onError: { [weak self] (error) in
                print(error)
                self?.tableView.headRefreshControl.endRefreshing()
            })
            .disposed(by: bag)
    }
}

extension TrendingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellVMs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.sp.dequeueReuseCell(TrendingCell.self, indexPath: indexPath)
        cell.bindData(vm: self.cellVMs[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.cellVMs[indexPath.row]
        let vc = IWebViewController(urlPath: item?.url)
        vc.webTitle = item?.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
