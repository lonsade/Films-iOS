//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol MoviesRoutingInput {
    func navigateToAboutFilm(onId id: Int, withType type: Int)
}

final class MoviesRouting: MoviesRoutingInput {

    var viewController: BaseHandlerController?

    func navigateToAboutFilm(onId id: Int, withType type: Int) {
        viewController?.openModule(withName: L10n.Module.aboutFilm) { moduleInput in
            guard let aboutFilminput = moduleInput as? AboutFilmInput else {
                return assertionFailure("Could not cast this moduleInput to \(String(describing: AboutFilmInput.self)).")
            }
            aboutFilminput.set(id: id, type: type)
        }
    }
}
