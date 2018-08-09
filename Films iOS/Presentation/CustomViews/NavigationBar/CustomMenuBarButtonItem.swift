//
//  CustomMenuBarButtonItem.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class CustomMenuBarButtonItem: UIBarButtonItem {
    override func awakeFromNib() {
        super.awakeFromNib()
        image = #imageLiteral(resourceName: "menuIcon").withRenderingMode(.alwaysOriginal)
    }
}
