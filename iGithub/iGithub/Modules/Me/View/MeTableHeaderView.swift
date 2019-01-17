//
//  MeTableHeaderView.swift
//  iGithub
//
//  Created by yfm on 2019/1/14.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit
import Kingfisher

class MeTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var reposButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!

    weak var delegate: ProfileHeaderViewDelegate?
    let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        reposButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.delegate?.gotoUserReposPage()
            })
            .disposed(by: bag)

        followersButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.delegate?.gotoFollowersPage()
            })
            .disposed(by: bag)

        followingButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.delegate?.gotoFollowingPage()
            })
            .disposed(by: bag)
    }
    
    func bindData(vm: ProfileHeaderItem?) {
        guard let _vm = vm else { return }

        userNameLabel.text = _vm.name
        descriptionLabel.text = _vm.bio
        createAtLabel.text = _vm.create_at
        reposLabel.text = _vm.repos
        followersLabel.text = _vm.followers
        followingLabel.text = _vm.following
        avatarImageView.sp.setImageWithRounded(path: _vm.avatar,
                                               cornerRadius: 25,
                                               targetSize: avatarImageView.frame.size)

    }
}
