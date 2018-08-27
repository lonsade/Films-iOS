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
    @IBOutlet weak var titleTextView: UITextView! {
        didSet {
            titleTextView.textContainerInset = .zero
            titleTextView.textContainer.lineFragmentPadding = 0
            titleTextView.textColor = .FTitleTextColor
            titleTextView.font = .FAboutFilmTitles
            overviewTextView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var overviewTextView: UITextView! {
        didSet {
            overviewTextView.textContainerInset = .zero
            overviewTextView.textContainer.lineFragmentPadding = 0
            overviewTextView.textColor = .FContentTextColor
            overviewTextView.font = .FSearchCardOverview
            overviewTextView.isScrollEnabled = false
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

    override func awakeFromNib() {
        self.layer.applySketchShadow(
            color: .FShadowColor,
            alpha: 0.6,
            x: 0,
            y: 0,
            blur: 2,
            spread: 0
        )
        self.layer.cornerRadius = 8
    }

    func setContent(image: String?, title: String, overview: String, vote: Float, adult: Bool) {

        posterImageView.downloadedFrom(link: image, contentMode: .scaleAspectFill)
        titleTextView.text = title
        overviewTextView.text = overview
        voteLabel.text = String(vote).withTMDb()
        ageLabel.text = (adult) ? "18+" : "0+"

    }

}
