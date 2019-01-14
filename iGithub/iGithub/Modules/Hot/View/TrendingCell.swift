//
//  TrendingCell.swift
//  iGithub
//
//  Created by yfm on 2019/1/11.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class TrendingCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoLanguageLabel: UILabel!
    @IBOutlet weak var repoStarLabel: UILabel!
    @IBOutlet weak var repoForksLabel: UILabel!
    @IBOutlet weak var languageImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func bindData(vm: TrendingCellViewModel?) {
        repoNameLabel.text = vm?.name
        repoDescriptionLabel.text = vm?.description
        repoLanguageLabel.text = vm?.language
        repoStarLabel.text = vm?.stars
        if let color = vm?.languageColor {
            languageImageView.image = languageImageView.image?.withRenderingMode(.alwaysTemplate)
            languageImageView.tintColor = UIColor.color(hex: color)
        }
        repoForksLabel.text = vm?.forks
    }
    
}
