//
//  FSegmentControl.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class FSegmentControl: UISegmentedControl {

    var selectedTextColor: UIColor = UIColor.FActiveTabTitleColorAboutFilm
    var selectedTintColor: UIColor = UIColor.FActiveTextColor
    var notSelectedTextColor: UIColor = UIColor.FInactiveTabTitleColorAboutFilm
    var notSelectesTintColor: UIColor = UIColor.FHRColor

    private var prevSelectedIndex: Int?

    /*
     Сделал свой массив вьюшек табов,
     потому что во время изменения состояния сегмент контроля
     менялся и исходный массив tabs.subviews
    */

    private lazy var tabViews: [UIView] = {
        var tabsV = [UIView]()
        for tab in self.subviews {
            tabsV.append(tab)
        }
        return tabsV
    }()

    private func setActiveTintColorOnItem(of index: Int) {
        if let prevIndex = prevSelectedIndex {
            tabViews[prevIndex].tintColor = notSelectesTintColor
        }
        prevSelectedIndex = index
        tabViews[index].tintColor = selectedTintColor
    }

    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: notSelectedTextColor], for: .normal)
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedTextColor], for: .selected)
        self.tintColor = notSelectesTintColor
        self.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
        setActiveTintColorOnItem(of: self.selectedSegmentIndex)
    }

    @objc private func tabChanged(_ sender: UISegmentedControl) {
        setActiveTintColorOnItem(of: sender.selectedSegmentIndex)
    }

}
