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

    func setTitle(title: String) {
        let attrStr = NSAttributedString(string: title.uppercased(), attributes: [
            .foregroundColor: UIColor.FTabNameColor,
            .font: UIFont.FTabName
        ])

        tabName.attributedText = attrStr
        tabName.textColor = (isSelected) ? UIColor.FActiveTextColor : UIColor.FTabNameColor

    }

    override var isSelected: Bool {
        didSet {
            tabName.textColor = (isSelected) ? UIColor.FActiveTextColor : UIColor.FTabNameColor
        }
    }

}
