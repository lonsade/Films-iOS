//
//  AboutFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutFilmViewController: UIViewController {

    @IBOutlet weak var tdbBarForFilm: UIStackView! {
        didSet {
            tdbBarForFilm.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            tdbBarForFilm.isLayoutMarginsRelativeArrangement = true
        }
    }

    private func setActiveTintColorOnItem(of index: Int) {

        for tab in tabs.subviews {
            tab.tintColor = UIColor.FHRColor
        }
        tabs.subviews[tabs.selectedSegmentIndex].tintColor = UIColor.FActiveTextColor

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

    func costomize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        costomize()
    }

}
