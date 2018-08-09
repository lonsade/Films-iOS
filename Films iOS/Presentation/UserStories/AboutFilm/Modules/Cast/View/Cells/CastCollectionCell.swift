//
//  CastCollectionCell.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class CastCollectionCell: UICollectionViewCell {

    private let baseUrl = "https://image.tmdb.org/t/p/w500"

    private func setImage(imageUrl: String?) {
        if let imageUrl = imageUrl {
            image.downloadedFrom(link: baseUrl+imageUrl, contentMode: .scaleToFill)
        } else {
            image.image = #imageLiteral(resourceName: "defaultAva")
        }
    }

    @IBOutlet weak var image: UIImageView! {
        didSet {
            //image.layer.masksToBounds = true
            image.setCornerRadius(byRoundingCorners: [.allCorners], size: 45)
        }
    }

    @IBOutlet weak var name: UILabel! {
        didSet {
            name.font = UIFont.FCastName
            name.textColor = UIColor.FTitleTextColor
        }
    }

    func setContent(image: String?, name: String) {
        self.name.text = name
        setImage(imageUrl: image)
    }
}
