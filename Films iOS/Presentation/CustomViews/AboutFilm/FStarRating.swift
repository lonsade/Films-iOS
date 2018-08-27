//
//  FStarRating.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class FStarRating: UIView {

    lazy private var backLayer: CALayer = .init()
    lazy private var frontLayer: CALayer = .init()
    lazy private var maskRating: CALayer = .init()

    override func awakeFromNib() {

        self.backgroundColor = UIColor.clear

        backLayer.frame = self.frame

        backLayer.contents = Asset.stars.image.cgImage

        backLayer.backgroundColor = UIColor.clear.cgColor
        backLayer.opacity = 0.3

        frontLayer.frame = self.frame
        frontLayer.contents = Asset.stars.image.cgImage
        frontLayer.backgroundColor = UIColor.clear.cgColor

        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(frontLayer)

        maskRating.backgroundColor = UIColor.white.cgColor
        frontLayer.mask = maskRating
    }

    func setRating(equal voteAverage: Float) {
        let maskWidth = self.frame.width * CGFloat(voteAverage / 10)
        maskRating.frame = CGRect(origin: self.frame.origin, size: CGSize(width: maskWidth, height: self.frame.height))
    }

}
