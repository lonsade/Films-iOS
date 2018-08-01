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
        //cell.layer.applySketchShadow(color: <#T##UIColor#>, alpha: <#T##Float#>, x: <#T##CGFloat#>, y: <#T##CGFloat#>, blur: <#T##CGFloat#>, spread: <#T##CGFloat#>)
    }

    func setContent(image: String, title: String, vote: Float, age: Int) {
        imagePoster.image = UIImage(named: image)
        self.title.text = title
        voteAverage.text = String(vote)
        ageLabel.text = String(age)
    }
}
