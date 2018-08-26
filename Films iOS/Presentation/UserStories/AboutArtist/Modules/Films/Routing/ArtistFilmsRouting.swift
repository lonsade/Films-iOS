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
    // FIXME: Хранить как BaseHandlerController.
    weak var viewController: ArtistFilmsViewController!

    func navigateToAboutFilm(withId id: Int) {
        viewController.openModule(withName: "AboutArtistFilm") { moduleInput in
            guard let aboutFilmPresenter = moduleInput as? AboutFilmPresenter else {
                fatalError("Could not cast this moduleInput to AboutFilmPresenter")
            }
            aboutFilmPresenter.set(id: id)
        }
    }
}
