//
//  LoginViewController.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTipsLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    let loginVM = LoginViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonClick(_ sender: Any) {
        AuthManager.share.createToken(userName: userNameTextField.text!,
                                      password: passwordTextField.text!)
        self.fetchData()
    }

    func fetchData() {
        loginVM.fetchUser()
            .subscribe(onNext: { (user) in
                UserManager.share.user = user
                (UIApplication.shared.delegate as? AppDelegate)?.loginSuccess()
            }, onError: { (error) in
                UserManager.share.remove()
            })
            .disposed(by: bag)
    }
}
