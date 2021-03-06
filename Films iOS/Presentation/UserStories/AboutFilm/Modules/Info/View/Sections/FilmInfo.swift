//
//  FilmInfo.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmInfo: UICollectionReusableView {

    private func costomizeInfoTitle(label: UILabel) {
        label.font = UIFont.FAboutFilmInfoTitleAndDesc
        label.textColor = UIColor.FTitleTextColor
    }

    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.setCornerRadius(byRoundingCorners: [.allCorners], size: 4)
            posterImageView.layer.applySketchShadow(
                color: UIColor.FShadowColor,
                alpha: 0.5,
                x: 0,
                y: 1,
                blur: 3,
                spread: 0
            )
        }
    }

    // FIXME: название не помещается полностью

    @IBOutlet weak var titleTextView: UITextView! {
        didSet {
            titleTextView.font = UIFont.FAboutFilmTitle
            titleTextView.textColor = UIColor.FTitleTextColor
            titleTextView.textContainerInset = .zero
            titleTextView.textContainer.lineFragmentPadding = 0
        }
    }
    @IBOutlet weak var starRating: FStarRating!
    @IBOutlet weak var markLabel: UILabel! {
        didSet {
            costomizeInfoTitle(label: markLabel)
        }
    }
    @IBOutlet weak var yearLabel: UILabel! {
        didSet {
            costomizeInfoTitle(label: yearLabel)
        }
    }
    @IBOutlet weak var runtimeLabel: UILabel! {
        didSet {
            costomizeInfoTitle(label: runtimeLabel)
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            costomizeInfoTitle(label: ageLabel)
        }
    }
    @IBOutlet weak var coutryLabel: UILabel! {
        didSet {
            costomizeInfoTitle(label: coutryLabel)
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.font = UIFont.FAboutFilmInfoTitleAndDesc
            descriptionTextView.textColor = UIColor.FContentTextColor
            descriptionTextView.textContainer.lineFragmentPadding = 0
            descriptionTextView.textContainerInset = .zero
        }
    }
    @IBOutlet weak var infoTitlesBlock: UIStackView! {
        didSet {
            infoTitlesBlock.isLayoutMarginsRelativeArrangement = true
            infoTitlesBlock.layoutMargins = UIEdgeInsets(top: 3, left: 0, bottom: 14, right: 0)
        }
    }

    func set(details: FilmDetail) {
        titleTextView.text = details.title ?? details.name ?? L10n.notInformation
        if let countries = details.productionCountries {
            coutryLabel.text = (!countries.isEmpty) ? countries[0].name : L10n.notInformation
        } else if let countries = details.originCountry {
            coutryLabel.text = (!countries.isEmpty) ? countries[0] : L10n.notInformation
        }
        descriptionTextView.text = details.overview
        markLabel.text = String(details.voteAverage).withTMDb()
        ageLabel.text = details.adult != nil ? L10n.adult : L10n.notAdult

        var validYear: Int
        if let date = details.releaseDate, !date.isEmpty, let yearInt = details.releaseDate?.getDate(withFormat: "yyyy-MM-dd").year {
            validYear = yearInt
        } else if
            let date = details.firstAirDate,
            !date.isEmpty,
            let yearInt = details.firstAirDate?.getDate(withFormat: "yyyy-MM-dd").year
        {
            validYear = yearInt
        } else {
            validYear = 1448
        }
        yearLabel.text = String(validYear)

        if let runtime = details.runtime {
            let time = runtime.getTimeFromIntDuration()
            // TODO: сделать через форматер
            runtimeLabel.text = String(time.0)+"h "+String(time.1)+"min"
        } else if let countSessions = details.numberOfSeasons {
            runtimeLabel.text = String(countSessions)+" seasons"
        } else {
            runtimeLabel.text = L10n.notInformation
        }

        posterImageView.downloadedFrom(link: details.posterPath, contentMode: .scaleAspectFill)

        // RAting
        starRating.setRating(equal: details.voteAverage)
    }

}

private extension Int {
    func getTimeFromIntDuration() -> (Int, Int) {
        let hours: Int = self / 60
        let minutes = self - (hours * 60)
        return (hours, minutes)
    }
}
