//
//  CALayerApplySketchShadow.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        masksToBounds = false
        shouldRasterize = false
        if spread == 0 {
            self.shadowPath = nil
        } else {
            let ddx = -spread
            let rect = bounds.insetBy(dx: ddx, dy: ddx)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
