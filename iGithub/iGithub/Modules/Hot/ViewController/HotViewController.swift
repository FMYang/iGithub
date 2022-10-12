//
//  HotViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/3.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//
//
//

import UIKit

class HotViewController: UIViewController {

    let bag = DisposeBag()

    let navTitles = ["Trending", "Popular"]

    var subViewControllers = [UIViewController]()

    /// navigation title view
    lazy var titleView: UISegmentedControl = {
        let view = UISegmentedControl(items: navTitles)
        view.selectedSegmentIndex = 0
        view.tintColor = .white
        if #available(iOS 13.0, *) {
            view.selectedSegmentTintColor = .white
        }
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.sp.theme_red], for: .selected)
        return view
    }()

    /// contentView
    lazy var pageScorllView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: IG_NaviHeight, width: screen_width, height: screen_height - IG_NaviHeight)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildViewControllers()
        layoutUI()
        self.loadPage(viewController: subViewControllers[0], index: 0)

        titleView.rx.controlEvent(UIControlEvents.valueChanged)
            .subscribe(onNext: { [weak self] in
                if let index = self?.titleView.selectedSegmentIndex {
                    self?.changeCurrentPage(index)
                }
            })
            .disposed(by: bag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.titleView = titleView
    }

    // MARK: - function
    func setupChildViewControllers() {
        let trendingVC = TrendingViewController()
        let popularVC = PopularViewController()
        subViewControllers = [trendingVC, popularVC]
    }

    func layoutUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: nil)

        self.view.addSubview(pageScorllView)

        pageScorllView.contentSize = CGSize(width: CGFloat(navTitles.count) * screen_width,
                                            height: pageScorllView.sp.height)

    }

    /// load page
    func loadPage(viewController: UIViewController, index: Int) {
        guard index >= 0, index < navTitles.count else {
            return
        }

        self.addChild(viewController)

        viewController.view.frame = CGRect(x: screen_width * CGFloat(index), y: 0.0, width: screen_width, height: screen_height - IG_NaviHeight - IG_TabbarHeight)
        self.pageScorllView.addSubview(viewController.view)
    }

    /// change page
    func changeCurrentPage(_ index: Int) {
        guard index >= 0, index < navTitles.count else {
            return
        }
        self.titleView.selectedSegmentIndex = index
        self.loadPage(viewController: subViewControllers[index], index: index)
        self.pageScorllView.setContentOffset(CGPoint.init(x: CGFloat(index) * screen_width, y: 0), animated: false)
    }
}

// MARK: - UIScrollView delegate
extension HotViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = lroundf(Float(scrollView.contentOffset.x / screen_width))
        self.changeCurrentPage(index)
    }
}

