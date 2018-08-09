//
//  ReviewCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    private let baseUrl = "https://image.tmdb.org/t/p/w500"

    @IBOutlet weak var personImage: UIImageView! {
        didSet {
            personImage.setCornerRadius(byRoundingCorners: [.allCorners], size: 45)
        }
    }

    @IBOutlet weak var name: UILabel! {
        didSet {
            name.font = UIFont.FCastName
            name.textColor = UIColor.FTitleTextColor
        }
    }

    @IBOutlet weak var rating: UILabel! {
        didSet {
            rating.font = UIFont.FReviewMark
            rating.textColor = UIColor.FActiveTextColor
        }
    }

    @IBOutlet weak var review: UITextView! {
        didSet {
            review.font = UIFont.FAboutFilmInfoTitleAndDesc
            review.textColor = UIColor.FContentTextColor
            review.textContainer.lineFragmentPadding = 0
            review.textContainerInset = .zero
        }
    }

//    func setContent(image: String?, name: String, rating: )
}
