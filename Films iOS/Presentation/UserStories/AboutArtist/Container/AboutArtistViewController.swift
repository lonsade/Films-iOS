//
//  AboutArtistViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutArtistViewController: UIViewController {

    /*Кастомизация линии под сегмент контролем*/
    @IBOutlet weak var lineUnderTabs: UIView! {
        didSet {
            lineUnderTabs.backgroundColor = UIColor.FHRColor
        }
    }

    @IBOutlet weak var tdbBarForFilm: UIStackView! {
        didSet {
            tdbBarForFilm.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            tdbBarForFilm.isLayoutMarginsRelativeArrangement = true
        }
    }

    private func costomize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        costomize()
    }

}
