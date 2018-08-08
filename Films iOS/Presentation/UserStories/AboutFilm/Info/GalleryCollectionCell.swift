//
//  GalleryCollectionCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {

    private let baseUrl = "https://image.tmdb.org/t/p/w500"

    func setImage(imageUrl: String) {
        image.downloadedFrom(link: baseUrl+imageUrl, contentMode: .scaleToFill)
    }

    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.masksToBounds = true
            image.setCornerRadius(byRoundingCorners: [.allCorners], size: 4)
        }
    }
}
