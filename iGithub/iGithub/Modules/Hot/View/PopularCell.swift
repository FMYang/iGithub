//
//  PopularCell.swift
//  iGithub
//
//  Created by yfm on 2019/1/8.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class PopularCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var licenceNameLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var repoStarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func bindData(vm: HotItemViewModel?) {
        repoNameLabel.text = vm?.repoName
        repoDescriptionLabel.text = vm?.repoDescription
        licenceNameLabel.text = vm?.licenceName
        updateTimeLabel.text = vm?.updateTime
        languageLabel.text = vm?.language
        repoStarLabel.text = vm?.star
    }
}
