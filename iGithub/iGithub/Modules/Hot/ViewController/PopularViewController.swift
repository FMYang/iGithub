//
//  PopularViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {

    // MARK: - properties
    let bag = DisposeBag()
    let hotVM = PopularViewModel()
    var items = [PopularItemViewModel?]()
    var page = 1
    let languauges = ["Swift", "Objective-C", "Java", "JavaScript", "Kotlin", "C", "C++"]
    var currentLanguage = "Swift"

    lazy var languageSelectedView: SelectedView = {
        let view = SelectedView.sp.loadNib()
        view.leftLabel.text = "Language"
        view.conditionLabel.text = "Swift"
        return view
    }()

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

        currentLanguage = languauges[0]

        languageSelectedView.selectedButton.rx.tap
            .subscribe(onNext: {
                var frame = self.languageSelectedView.conditionView.frame
                frame.origin.y += IG_NaviHeight+9
                TDWDropDownMenu.show(frame: frame, data: self.languauges, callBack: { [weak self] (str) in
                    self?.page = 1
                    self?.languageSelectedView.conditionLabel.text = str
                    self?.currentLanguage = str
                    self?.tableView.setContentOffset(.zero, animated: false)
                    self?.tableView.headRefreshControl.beginRefreshing()
                })
            })
            .disposed(by: bag)

        addRefresh()
    }

    // MARK: - fuction
    func layoutUI() {
        self.view.addSubview(languageSelectedView)
        self.view.addSubview(tableView)
        languageSelectedView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(languageSelectedView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
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
        hotVM.fetchPopularRepo(q: currentLanguage, sort: "stars", page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.page == 1 {
                    self?.items.removeAll()
                }
                self?.items += result
                self?.tableView.reloadData()
                self?.page += 1
                self?.tableView.headRefreshControl.endRefreshing()
                self?.tableView.footRefreshControl.endRefreshing()
            }, onError: { [weak self] (error) in
                print(error)
                self?.tableView.headRefreshControl.endRefreshing()
                self?.tableView.footRefreshControl.endRefreshing()
            })
            .disposed(by: bag)
    }
}

extension PopularViewController: UITableViewDataSource, UITableViewDelegate {
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
