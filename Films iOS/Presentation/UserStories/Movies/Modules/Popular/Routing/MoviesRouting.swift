//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol MoviesRoutingInput {
    func navigateToAboutFilm(withId id: Int)
}

final class MoviesRouting: MoviesRoutingInput {
    weak var viewController: PopularFilmsViewController!

    func navigateToAboutFilm(withId id: Int) {
        viewController.openModule(withName: "AboutFilm")
    }
}
