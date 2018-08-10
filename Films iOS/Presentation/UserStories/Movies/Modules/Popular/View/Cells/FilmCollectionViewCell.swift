//
//  FilmCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView! {
        didSet {
            imagePoster.layer.masksToBounds = true
            imagePoster.setCornerRadius(byRoundingCorners: [.topLeft, .topRight], size: 4)
        }
    }

    @IBOutlet weak var title: UITextView! {
        didSet {
            title.textContainerInset = .zero
            title.textContainer.lineFragmentPadding = 0
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

    func setContent(image: String?, title: String, vote: Float, age: Int) {

        imagePoster.downloadedFrom(link: image, contentMode: .scaleToFill)
        self.title.text = title
        voteAverage.text = String(vote).withTMDb()
        ageLabel.text = String(age)

    }
}
