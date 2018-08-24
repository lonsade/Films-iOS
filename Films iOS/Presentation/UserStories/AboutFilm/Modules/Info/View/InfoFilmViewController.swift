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

    var router: InfoRouting!
    var datasource: IDetailsFilmDataSourceOutput!
    var presenter: IDetailsFilmPresenter!

    @IBOutlet weak var collectionSimilarFilms: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        InfoViewAssembly.instance().inject(into: self)
        router.viewController = self
        datasource.delegate = self
        presenter.setDetailsFilm()
        presenter.setGallery()
        presenter.setSimilar()
    }

}

extension InfoFilmViewController: DetailsFilmDataSourceDelegate {

    func imagesWasAdded(images: [GalleryImage]) {
        galleryDisplayManager.collectionGallery?.reloadData()
    }

    func detailsWasAdded(details: FilmDetail) {
        filmTitle.text = details.title
        country.text = details.productionCountries[0].name
        descriptionFilm.text = details.overview
        filmMark.text = String(details.voteAverage).withTMDb()

        var validYear: Int
        if !details.releaseDate.isEmpty, let yearInt = details.releaseDate.getDate(withFormat: "yyyy-MM-dd").year {
            validYear = yearInt
        } else {
            validYear = 1448
        }
        year.text = String(validYear)

        if let runtime = details.runtime {
            let time = runtime.getTimeFromIntDuration()
            // TODO: сделать через форматер
            duration.text = String(time.0)+"h "+String(time.1)+"min"
        } else {
            duration.text = "No Information"
        }

        poster.downloadedFrom(link: details.posterPath, contentMode: .scaleAspectFill)

        // RAting
        rating.setRating(equal: details.voteAverage)

    }
}

extension InfoFilmViewController: ArtistMoviesDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

private extension Int {
    func getTimeFromIntDuration() -> (Int, Int) {
        let hours: Int = self / 60
        let minutes = self - (hours * 60)
        return (hours, minutes)
    }
}
