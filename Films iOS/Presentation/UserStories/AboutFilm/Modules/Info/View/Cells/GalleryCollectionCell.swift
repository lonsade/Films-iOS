//
//  GalleryCollectionCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {

    func setImage(imageUrl: String) {
        image.downloadedFrom(link: imageUrl, contentMode: .scaleAspectFill)
    }

    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.masksToBounds = true
            image.setCornerRadius(byRoundingCorners: [.allCorners], size: 4)
        }
    }
}
