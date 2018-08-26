//
//  FilmVideos.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class FilmVideos: UICollectionReusableView {

    @IBOutlet weak var videosCollectionView: UICollectionView! {
        didSet {
            videosCollectionView.backgroundColor = UIColor.blue
        }
    }
}
