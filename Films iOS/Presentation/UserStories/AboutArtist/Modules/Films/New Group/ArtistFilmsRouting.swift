//
//  ArtistFilmsRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol ArtistFilmsRoutingInput {
    func navigateToAboutFilm(withId id: Int)
}

final class ArtistFilmsRouting: ArtistFilmsRoutingInput {
    weak var viewController: ArtistFilmsViewController!

    func navigateToAboutFilm(withId id: Int) {
        viewController.openModule(withName: "AboutArtistFilm")
    }
}