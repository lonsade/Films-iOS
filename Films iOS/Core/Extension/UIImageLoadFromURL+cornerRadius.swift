//
//  UIImageLoadFromURL.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String?, contentMode mode: UIViewContentMode = .scaleAspectFit) {

        let baseUrl = "https://image.tmdb.org/t/p/w500"

        if let link = link, let url = URL(string: baseUrl + link) {
            downloadedFrom(url: url, contentMode: mode)
        } else {
            self.image = #imageLiteral(resourceName: "group")
        }
    }

    func setCornerRadius(byRoundingCorners: UIRectCorner, size: Int) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: byRoundingCorners,
            cornerRadii: CGSize(width: size, height: size)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
