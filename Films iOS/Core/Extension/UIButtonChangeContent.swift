//
//  UIButtonChangeContent.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

extension UIButton {
    func setFormatTitle(text: String, color: UIColor, font: UIFont) {
        self.setAttributedTitle(
            NSAttributedString(
                string: text,
                attributes: [
                    .foregroundColor: color,
                    .font: font
                ]
            ),
            for: .normal
        )
    }
}
