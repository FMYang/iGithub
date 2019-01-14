//
//  SelectedView.swift
//  iGithub
//
//  Created by yfm on 2019/1/9.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import UIKit

class SelectedView: UIView {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var conditionView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        conditionView.layer.borderColor = UIColor.darkGray.cgColor
        conditionView.layer.borderWidth = 0.5
        conditionView.layer.cornerRadius = 4
    }
}
