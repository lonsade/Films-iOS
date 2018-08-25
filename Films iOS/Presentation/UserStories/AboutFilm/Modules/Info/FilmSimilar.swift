//
//  FilmSimilar.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmSimilar: UICollectionReusableView {

    @IBOutlet weak var similarLabel: UILabel! {
        didSet {
            similarLabel.font = UIFont.FAboutFilmTitles
            similarLabel.textColor = UIColor.FTitleTextColor
            similarLabel.text = "See also"
        }
    }
    @IBOutlet weak var similarCollectionView: UICollectionView!
}
