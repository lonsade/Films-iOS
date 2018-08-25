//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol MoviesRoutingInput {
    func navigateToAboutFilm(onId id: Int)
}

final class MoviesRouting: MoviesRoutingInput {

    var viewController: BaseHandlerController?

    func navigateToAboutFilm(onId id: Int) {
        viewController?.openModule(withName: "AboutFilm") { moduleInput in
            guard let aboutFilminput = moduleInput as? AboutFilmInput else {
                fatalError("Could not cust moduleInput to AboutFilmInput")
            }
            aboutFilminput.set(id: id)
        }
    }
}
