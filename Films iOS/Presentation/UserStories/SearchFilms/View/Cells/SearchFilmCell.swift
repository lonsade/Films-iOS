//
//  SearchFilmCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchFilmCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.setCornerRadius(byRoundingCorners: [.bottomLeft, .topLeft], size: 8)
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .FTitleTextColor
            titleLabel.font = .FAboutFilmTitles
        }
    }

    @IBOutlet weak var overviewLabel: UILabel! {
        didSet {
            overviewLabel.textColor = .FContentTextColor
            overviewLabel.font = .FSearchCardOverview
        }
    }

    @IBOutlet weak var voteLabel: UILabel! {
        didSet {
            voteLabel.textColor = .FActiveTextColor
            voteLabel.font = .FReviewMark
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.textColor = .FTitleTextColor
            ageLabel.font = .FReviewMark
        }
    }

    func setContent(image: String?, title: String, overview: String, vote: Float, adult: Bool) {

        posterImageView.downloadedFrom(link: image, contentMode: .scaleAspectFill)
        titleLabel.text = title
        overviewLabel.text = overview
        voteLabel.text = String(vote).withTMDb()
        ageLabel.text = (adult) ? "18+" : "0+"

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .FBackgroundColorPoster
        contentView.layer.applySketchShadow(
            color: .FShadowColor,
            alpha: 1,
            x: 0,
            y: 1,
            blur: 6,
            spread: 0
        )
    }

}
