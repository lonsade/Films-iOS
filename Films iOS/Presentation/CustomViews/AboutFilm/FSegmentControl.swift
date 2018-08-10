//
//  FSegmentControl.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol FSegmentControlDelegate: class {
    func itemWasSelected(at index: Int)
}

final class FSegmentControl: UISegmentedControl {

    var selectedTextColor: UIColor = .FActiveTabTitleColorAboutFilm
    var selectedTintColor: UIColor = .FActiveTextColor
    var notSelectedTextColor: UIColor = .FInactiveTabTitleColorAboutFilm
    var notSelectesTintColor: UIColor = .FHRColor

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

    weak var delegate: FSegmentControlDelegate?

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
        delegate?.itemWasSelected(at: self.selectedSegmentIndex)
    }

}
