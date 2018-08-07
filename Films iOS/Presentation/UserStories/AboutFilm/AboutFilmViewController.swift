//
//  AboutFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutFilmViewController: UIViewController {

    /*
        Сделал свой массив вьюшек табов,
        потому что во время изменения состояния сегмент контроля
        менялся и исходный массив tabs.subviews
    */

    private lazy var tabViews: [UIView] = {
        var tabsV = [UIView]()
        for tab in self.tabs.subviews {
            tabsV.append(tab)
        }
        return tabsV
    }()

    private func setActiveTintColorOnItem(of index: Int) {
        for tabIndex in tabViews.indices {
            if tabIndex == index {
                tabViews[tabIndex].tintColor = UIColor.FActiveTextColor
            } else {
                tabViews[tabIndex].tintColor = UIColor.FHRColor
            }
        }
    }

    @IBOutlet weak var tdbBarForFilm: UIStackView! {
        didSet {
            tdbBarForFilm.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            tdbBarForFilm.isLayoutMarginsRelativeArrangement = true
        }
    }

    @IBOutlet weak var tabs: UISegmentedControl! {
        didSet {
            tabs.translatesAutoresizingMaskIntoConstraints = false
            //tabs.tintColor = UIColor.FHRColor
            tabs.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.FInactiveTabTitleColorAboutFilm], for: .normal)
            tabs.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.FActiveTabTitleColorAboutFilm], for: .selected)

            setActiveTintColorOnItem(of: tabs.selectedSegmentIndex)
        }
    }

    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        setActiveTintColorOnItem(of: sender.selectedSegmentIndex)
    }

    private func costomize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        costomize()
    }

}
