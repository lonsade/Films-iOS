//
//  TabNameCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class TabNameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tabName: UILabel!

    var isActive: Bool = false

    func setTitle(title: String) {
        let attrStr = NSAttributedString(string: title.uppercased(), attributes: [
            .foregroundColor: UIColor.FTabNameColor,
            .font: UIFont.FTabName
        ])
        tabName.attributedText = attrStr
        tabName.textColor = (isActive) ? UIColor.FActiveTextColor : UIColor.FTabNameColor
    }

    func changeActive(_ active: Bool) {
        isActive = active
        tabName.textColor = (isActive) ? UIColor.FActiveTextColor : UIColor.FTabNameColor
    }

}
