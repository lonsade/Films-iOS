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
            titleTextView.isScrollEnabled = false
            titleTextView.isSelectable = false
        }
    }
    @IBOutlet weak var overviewTextView: UITextView! {
        didSet {
            overviewTextView.textContainerInset = .zero
            overviewTextView.textContainer.lineFragmentPadding = 0
            overviewTextView.textColor = .FContentTextColor
            overviewTextView.font = .FSearchCardOverview
            overviewTextView.isScrollEnabled = false
            overviewTextView.isSelectable = false
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
        super.awakeFromNib()
        self.layer.applySketchShadow(
            color: .FShadowColor,
            alpha: 0.6,
            x: 0,
            y: 0,
            blur: 2,
            spread: 0
        )
        self.layer.cornerRadius = 8
        self.backgroundColor = .FBackgroundColorPoster
    }

    func setContent(image: String?, title: String, overview: String, vote: Float, adult: Bool) {

        posterImageView.downloadedFrom(link: image, contentMode: .scaleAspectFill)
        titleTextView.text = title
        titleTextView.setLineHeight(21, withAttributes: [.foregroundColor: UIColor.FTitleTextColor, .font: UIFont.FAboutFilmTitles])
        overviewTextView.text = overview
        voteLabel.text = String(vote).withTMDb()
        ageLabel.text = (adult) ? "18+" : "0+"

    }

}

private extension UITextView {
    func setLineHeight(_ amount: CGFloat, withAttributes attributes: [NSAttributedStringKey: Any]) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 21
        var selfAttributes = attributes
        selfAttributes[NSAttributedStringKey.paragraphStyle] = style
        self.attributedText = NSAttributedString(string: self.text, attributes: selfAttributes)
    }
}
