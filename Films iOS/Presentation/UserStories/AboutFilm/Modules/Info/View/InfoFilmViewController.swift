//
//  InfoFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class InfoFilmViewController: BaseViewController {

    private func costomizeInfoTitle(label: UILabel) {
        label.font = UIFont.FAboutFilmInfoTitleAndDesc
        label.textColor = UIColor.FTitleTextColor
    }

    @IBOutlet weak var collectionVideo: UICollectionView!

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
            descriptionFilm.textContainerInset = .zero
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

    @IBOutlet weak var infoTitlesBlock: UIStackView! {
        didSet {
            infoTitlesBlock.isLayoutMarginsRelativeArrangement = true
            infoTitlesBlock.layoutMargins = UIEdgeInsets(top: 3, left: 0, bottom: 14, right: 0)
        }
    }

    @IBOutlet weak var poster: UIImageView! {
        didSet {
            poster.setCornerRadius(byRoundingCorners: [.allCorners], size: 4)
            poster.layer.applySketchShadow(
                color: UIColor.FShadowColor,
                alpha: 0.5,
                x: 0,
                y: 1,
                blur: 3,
                spread: 0
            )
        }
    }

    @IBOutlet weak var rating: FStarRating!

    @IBOutlet weak var galleryCollection: UICollectionView!

    var galleryDisplayManager: GalleryDisplayManager! {
        didSet {
            galleryDisplayManager.collectionGallery = self.galleryCollection
        }
    }

    var similarDisplayManager: SimilarFilmsDisplayManager! {
        didSet {
            similarDisplayManager.collectionFilms = collectionSimilarFilms
            similarDisplayManager.delegate = self
        }
    }

    var infoFilmDisplayManager: InfoFilmDisplayManager! {
        didSet {
            infoFilmDisplayManager.infoFilmCollectionView = aboutFilmCollectionView
        }
    }

    var router: InfoRouting!
    var datasource: IDetailsFilmDataSourceOutput!
    var presenter: IDetailsFilmPresenter!

    @IBOutlet weak var collectionSimilarFilms: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        InfoViewAssembly.instance().inject(into: self)
        router.viewController = self
//        datasource.delegate = self
        presenter.setDetailsFilm()
        presenter.setGallery()
//        presenter.setSimilar()
    }

    @IBOutlet weak var aboutFilmCollectionView: UICollectionView!

}

extension InfoFilmViewController: ArtistMoviesDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}
