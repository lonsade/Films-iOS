//
//  FilmCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {

    private let baseUrlImage = "https://image.tmdb.org/t/p/w500"

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.textColor = UIColor.FTitleTextColor
            title.font = UIFont.FTitleContent
        }
    }
    @IBOutlet weak var voteAverage: UILabel! {
        didSet {
            voteAverage.textColor = UIColor.FActiveTextColor
            voteAverage.font = UIFont.FActiveTextOnContent
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.textColor = UIColor.FTitleTextColor
            ageLabel.font = UIFont.FTextAgeOnFilmCollection
        }
    }

    override func awakeFromNib() {
        self.layer.cornerRadius = 4.0
        self.backgroundColor = UIColor.FBackgroundColorPoster

        self.layer.applySketchShadow(
            color: UIColor.FShadowColor,
            alpha: 0.5,
            x: 0,
            y: 1,
            blur: 3,
            spread: 0
        )
    }

    func setContent(image: String, title: String, vote: Float, age: Int) {

        imagePoster.downloadedFrom(link: baseUrlImage+image, contentMode: .scaleToFill)
        self.title.text = title
        voteAverage.text = "TMDDb "+String(vote)
        ageLabel.text = String(age)

    }
}
