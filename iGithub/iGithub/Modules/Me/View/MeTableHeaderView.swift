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

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var homePageLabel: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    func bindData() {
        guard let user = UserManager.share.user else { return }
        
        userNameLabel.text = user.name
        descriptionLabel.text = user.bio
        emailLabel.text = user.email
        homePageLabel.text = user.blog
        
        if let repos = user.public_repos {
            if repos > 1000 {
                reposLabel.text = String(format: "%.1f", Double(repos)/1000.0)+"k"
            } else {
                reposLabel.text = String(repos)
            }
        }
        
        if let followers = user.followers {
            if followers > 1000 {
                followersLabel.text = String(format: "%.1f", Double(followers)/1000.0)+"k"
            } else {
                followersLabel.text = String(followers)
            }
        }
        
        if let following = user.following {
            if following > 1000 {
                followingLabel.text = String(format: "%.1f", Double(following)/1000.0)+"k"
            } else {
                followingLabel.text = String(following)
            }
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 25, targetSize: avatarImageView.frame.size)
        if let url = URL(string: user.avatar_url ?? "") {
            avatarImageView.kf.setImage(with: url,
                                        placeholder: nil,
                                        options: [.processor(processor),
                                                  .cacheSerializer(FormatIndicatedCacheSerializer.png)])
            bgImageView.kf.setImage(with: url)
        }
    }
}
