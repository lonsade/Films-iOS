//
//  CALayerApplySketchShadow.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

extension CALayer {

// FIXME: Функцию тяжело читать, потому что её код сливается с определением параметров.
// Тебе нужно только перенести ") {" на другую строчку и уже станет легче читать её.
//    func applySketchShadow(
//        color: UIColor = .black,
//        alpha: Float = 0.5,
//        x: CGFloat = 0,
//        y: CGFloat = 2,
//        blur: CGFloat = 4,
//        spread: CGFloat = 0
//    ) {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
