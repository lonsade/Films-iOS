//
//  InfoFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class InfoFilmViewController: UIViewController {

    /*Настройка коллекции трейлеров*/
    @IBOutlet weak var collectionVideo: UICollectionView!

    @IBOutlet weak var infoBlock: UIStackView! {
        didSet {
            infoBlock.layoutMargins = UIEdgeInsets(top: 20, left: 17, bottom: 10, right: 39)
            infoBlock.isLayoutMarginsRelativeArrangement = true
        }
    }

    @IBOutlet weak var infoTitlesBlock: UIStackView! {
        didSet {
            infoTitlesBlock.layoutMargins = UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 0)
            infoTitlesBlock.isLayoutMarginsRelativeArrangement = true
        }
    }

    private func costomizeInfoTitle(label: UILabel) {
        label.font = UIFont.FAboutFilmInfoTitleAndDesc
        label.textColor = UIColor.FTitleTextColor
    }

    @IBOutlet weak var filmMark: UILabel! {
        didSet {
            costomizeInfoTitle(label: filmMark)
        }
    }
    @IBOutlet weak var year: UILabel! {
        didSet {
            costomizeInfoTitle(label: year)
        }
    }
    @IBOutlet weak var duration: UILabel! {
        didSet {
            costomizeInfoTitle(label: duration)
        }
    }
    @IBOutlet weak var age: UILabel! {
        didSet {
            costomizeInfoTitle(label: age)
        }
    }
    @IBOutlet weak var country: UILabel! {
        didSet {
            costomizeInfoTitle(label: country)
        }
    }

    @IBOutlet weak var filmTitle: UITextView! {
        didSet {
            filmTitle.font = UIFont.FAboutFilmTitle
            filmTitle.textColor = UIColor.FTitleTextColor
            filmTitle.textContainerInset = .zero
            filmTitle.textContainer.lineFragmentPadding = 0
        }
    }
    @IBOutlet weak var descriptionFilm: UITextView! {
        didSet {
            descriptionFilm.font = UIFont.FAboutFilmInfoTitleAndDesc
            descriptionFilm.textColor = UIColor.FContentTextColor
            descriptionFilm.textContainer.lineFragmentPadding = 0

            descriptionFilm.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 39)
        }
    }

    @IBOutlet weak var galleryLabel: UILabel! {
        didSet {
            galleryLabel.font = UIFont.FAboutFilmTitles
            galleryLabel.textColor = UIColor.FTitleTextColor
        }
    }

    @IBOutlet weak var seeAlsoTitle: UILabel! {
        didSet {
            seeAlsoTitle.font = UIFont.FAboutFilmTitles
            seeAlsoTitle.textColor = UIColor.FTitleTextColor
        }
    }

    @IBOutlet weak var mainStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let ns1 = NSLayoutConstraint(item: galleryLabel, attribute: .leading, relatedBy: .equal, toItem: mainStack, attribute: .leading, multiplier: 1, constant: 16)

        mainStack.addConstraint(ns1)

    }
}
