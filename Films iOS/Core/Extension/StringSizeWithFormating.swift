//
//  StringSizeWithFormating.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

extension String {
    func getSizeWithFormating(font: UIFont) -> CGSize {
        let attrStr = NSAttributedString(string: self, attributes: [.font: font])
        return attrStr.size()
    }
}
