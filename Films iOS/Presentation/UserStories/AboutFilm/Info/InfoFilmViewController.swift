//
//  InfoFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class InfoFilmViewController: UIViewController {

    var detailsFilmDataSource: IDetailsFilmDataSourceOutput!
    var detailsFilmPresenter: IDetailsFilmPresenter!

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
            infoTitlesBlock.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 14, right: 0)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        InfoViewAssembly.instance().inject(into: self)
        detailsFilmDataSource.delegate = self
        detailsFilmPresenter.setDetailsFilm()
    }
}

extension InfoFilmViewController: DetailsFilmDataSourceDelegate {

    func detailsWasAdded(details: FilmDetail) {
        filmTitle.text = details.title
        country.text = details.productionCountries[0].name
        descriptionFilm.text = details.overview
        filmMark.text = String(details.voteAverage).withTMDb()

        var validYear: Int
        guard let yearInt = details.releaseDate.getDate(withFormat: "yyyy-MM-dd").year else {
            #if DEBUG
            fatalError("Invalid Date")
            #else
            validYear = 1448
            #endif
        }
        validYear = yearInt
        year.text = String(validYear)

        let time = details.runtime.getTimeFromIntDuration()

        // TODO: сделать через форматер

        duration.text = String(time.0)+"h "+String(time.1)+"min"

        poster.downloadedFrom(link: "https://image.tmdb.org/t/p/w500"+details.posterPath, contentMode: .scaleToFill)
    }
}
