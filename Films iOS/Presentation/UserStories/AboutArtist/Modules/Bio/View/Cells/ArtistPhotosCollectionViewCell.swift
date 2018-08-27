//
//  ArtistPhotosCollectionViewCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ArtistPhotosCollectionViewCell: UICollectionViewCell {
    func setImage(imageUrl: String?) {
        if let imageUrl = imageUrl {
            artistPhotoImageView.downloadedFrom(link: imageUrl, contentMode: .scaleAspectFill)
        } else {
            artistPhotoImageView.image = Asset.defaultAva.image
        }
    }
    @IBOutlet weak var artistPhotoImageView: UIImageView! {
        didSet {
            artistPhotoImageView.setCornerRadius(byRoundingCorners: [.allCorners], size: 8)
        }
    }
}
