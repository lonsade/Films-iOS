//
//  FilmCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    func setTextForTitle(text: String) {
        let attrStr = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.FTitleTextColor,
            .font: UIFont.FTitleContent
        ])
        title.attributedText = attrStr
    }

    func setTextForVoteAverage(vote: Float) {
        let attrStr = NSAttributedString(string: String(vote), attributes: [
            .foregroundColor: UIColor.FActiveTextColor,
            .font: UIFont.FActiveTextOnContent
        ])
        voteAverage.attributedText = attrStr
    }

    func setTextForAge(age: Int) {
        let attrStr = NSAttributedString(string: String(age), attributes: [
            .foregroundColor: UIColor.FTitleTextColor,
            .font: UIFont.FTextAgeOnFilmCollection
        ])
        ageLabel.attributedText = attrStr
    }

}
