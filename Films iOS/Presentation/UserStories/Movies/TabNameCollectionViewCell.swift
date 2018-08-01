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
        let attrStr = NSAttributedString(string: title, attributes: [
            .foregroundColor: UIColor.FTabNameColor,
            .font: UIFont.FTabName
        ])
        tabName.attributedText = attrStr
    }
    
    func changeActive(active: Bool) {
        let color = (active) ? UIColor.FActiveTextColor : UIColor.FTabNameColor
        tabName.textColor = color
    }
    
}
