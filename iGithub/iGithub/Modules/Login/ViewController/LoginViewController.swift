//
//  LoginViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    fileprivate let webAuthUrl = "https://github.com/login/oauth/authorize?client_id=5d9a014c274cbae38154&scope=nil"

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTipsLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self;
        return view
    }()

    let loginVM = LoginViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.load(URLRequest(url: URL(string: webAuthUrl)!))
    }

    @IBAction func loginButtonClick(_ sender: Any) {

        self.view.endEditing(true)

        AuthManager.share.createToken(userName: userNameTextField.text!,
                                      password: passwordTextField.text!)
        self.fetchData()
    }

    func fetchData() {
        self.view.sp.showLoading("Login...")
        loginVM.fetchUser()
            .subscribe(onNext: { [weak self] (user) in
                self?.view.sp.hideLoading()
                UserManager.share.user = user
                (UIApplication.shared.delegate as? AppDelegate)?.loginSuccess()
            }, onError: { [weak self] (error) in
                self?.view.sp.hideWithMessage(title: "UserName or password error!")
                UserManager.share.remove()
            })
            .disposed(by: bag)
    }
}

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(self.webView.url?.absoluteString)
//        processCallBack()
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(self.webView.url?.absoluteString)
        processCallBack()
    }
    
    func processCallBack() {
        let code = self.webView.url?.absoluteString.components(separatedBy: "=").last?.removingPercentEncoding;
        getAccessToken(code: code ?? "")
    }
    
    func getAccessToken(code: String) {
        guard code.count > 0 else { return }
        print(code)
        var request = URLRequest(url: URL(string: "https://github.com/login/oauth/access_token")!)
        request.httpMethod = "POST"
        request.httpBody = "client_id=\(client_id)&client_secret=\(client_secret)&code=\(code)&redirect_uri=\(redirectUri)".data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                let dataText = String(data: data!, encoding: .utf8)
                var access_token: String?
                if let text = dataText, text.count > 0, text.contains("access_token") {
                    let arr: Array = text.components(separatedBy: "&")
                    arr.forEach { (str) in
                        if str.contains("access_token") {
                            access_token = str.components(separatedBy: "=").last?.removingPercentEncoding;
                        }
                    }
                }
                
                if let token = access_token, token.count > 0 {
                    AuthManager.share.token = token
                    DispatchQueue.main.async {
                        self.fetchData()
                    }
                }
                print("获取到token = \(access_token)")

            }
        }.resume();
    }
}

