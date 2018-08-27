//
//  FilmGallery.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmGallery: UICollectionReusableView {

    @IBOutlet weak var galleryLabel: UILabel! {
        didSet {
            galleryLabel.font = UIFont.FAboutFilmTitles
            galleryLabel.textColor = UIColor.FTitleTextColor
            galleryLabel.text = L10n.AboutFilm.Info.galleryLabel
        }
    }

    @IBOutlet weak var similarLabel: UILabel! {
        didSet {
            similarLabel.font = UIFont.FAboutFilmTitles
            similarLabel.textColor = UIColor.FTitleTextColor
            similarLabel.text = L10n.AboutFilm.Info.seeAlsoLabel
        }
    }
    @IBOutlet weak var galleryCollectionView: UICollectionView!
}
