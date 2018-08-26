//
//  InfoRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol InfoRoutingInput {
    func navigateToAboutFilm(withId id: Int)
}

final class InfoRouting: InfoRoutingInput {

    weak var viewController: InfoFilmViewController!

    func navigateToAboutFilm(withId id: Int) {
        viewController.openModule(withName: "AboutFilm") { moduleInput in
            guard let aboutFilmPresenter = moduleInput as? AboutFilmInput else {
                fatalError("Could not cast this moduleInput to AboutFilmInput")
            }
            aboutFilmPresenter.set(id: id)
        }
    }
}
