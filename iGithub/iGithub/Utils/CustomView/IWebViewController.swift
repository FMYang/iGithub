//
//  IWebViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/10.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class IWebViewController: UIViewController {

    let bag = DisposeBag()

    var webTitle: String?

    lazy var backButtonItem: UIBarButtonItem = {
        let backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        backButton.setImage(UIImage(named: "icon-back-arrow"), for: .normal)
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                if let strongSelf = self {
                    if strongSelf.webView.canGoBack {
                        strongSelf.webView.goBack()
                    } else {
                        strongSelf.navigationController?.popViewController(animated: true)
                    }
                }
            })
            .disposed(by: bag)
        let item = UIBarButtonItem(customView: backButton)
        return item
    }()

    lazy var closeButtonItem: UIBarButtonItem = {
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        closeButton.setImage(UIImage(named: "icon-delete"), for: .normal)
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: bag)
        let item = UIBarButtonItem(customView: closeButton)
        return item
    }()

    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        return view
    }()

    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.trackTintColor = UIColor.white
        view.progressTintColor = UIColor.sp.theme_red
        return view
    }()

    convenience init(urlPath: String?) {
        self.init()

        guard let _urlPath = urlPath, let _url = URL(string: _urlPath) else {
            return
        }
        self.webView.load(URLRequest(url: _url))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = []

        self.title = webTitle

        layoutUI()

        self.webView.rx.observe(Double.self, #keyPath(WKWebView.estimatedProgress))
            .subscribe(onNext: { [weak self] (progress) in
                self?.progressView.setProgress(Float(progress ?? 0.0), animated: true)
            })
            .disposed(by: bag)

        self.navigationItem.leftBarButtonItems = [backButtonItem]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - function
    func layoutUI() {
        self.view.addSubview(progressView)
        self.view.addSubview(webView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }

        webView.snp.makeConstraints { (make) in
            make.top.equalTo(progressView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension IWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.progress = 0.0
        self.title = webTitle ?? webView.title
         if webView.canGoBack {
            self.navigationItem.leftBarButtonItems = [backButtonItem, closeButtonItem]
        } else {
            self.navigationItem.leftBarButtonItems = [backButtonItem]
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView.progress = 0.0
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url?.absoluteString ?? "")
        print(navigationAction.navigationType.rawValue)
        decisionHandler(.allow)
    }
}
