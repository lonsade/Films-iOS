//
//  FStarRating.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class FStarRating: UIView {

    private var backLayer: CALayer!
    private var frontLayer: CALayer!

    private var maskRating: CALayer!

    public var backStars = "group2"
    public var frontStars = "group2"

    override func awakeFromNib() {

        self.backgroundColor = UIColor.clear

        backLayer = CALayer()

        backLayer.frame = self.frame
        backLayer.contents = UIImage(named: backStars)?.cgImage
        backLayer.backgroundColor = UIColor.clear.cgColor
        backLayer.opacity = 0.3

        frontLayer = CALayer()

        frontLayer.frame = self.frame
        frontLayer.contents = UIImage(named: frontStars)?.cgImage
        frontLayer.backgroundColor = UIColor.clear.cgColor

        self.layer.addSublayer(backLayer)
        self.layer.addSublayer(frontLayer)

        maskRating = CALayer()
        maskRating.backgroundColor = UIColor.white.cgColor
        frontLayer.mask = maskRating
    }

    func setRating(voteAverage: Float) {
        let maskWidth = self.frame.width * CGFloat(voteAverage / 10)
        maskRating.frame = CGRect(origin: self.frame.origin, size: CGSize(width: maskWidth, height: self.frame.height))
    }

}
