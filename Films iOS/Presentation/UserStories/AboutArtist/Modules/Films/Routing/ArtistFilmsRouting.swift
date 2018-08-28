//
//  ArtistFilmsRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol ArtistFilmsRoutingInput: BaseRoutingProtocol {
    func navigateToAboutFilm(withId id: Int, withType type: Int)
}

final class ArtistFilmsRouting: ArtistFilmsRoutingInput {

    weak var viewController: BaseHandlerController?

    func navigateToAboutFilm(withId id: Int, withType type: Int) {
        viewController?.openModule(withName: L10n.Module.aboutArtistFilm) { moduleInput in
            guard let aboutFilmPresenter = moduleInput as? AboutFilmPresenter else {
                return assertionFailure("Could not cast this moduleInput to \(String(describing: AboutFilmPresenter.self)).")
            }
            aboutFilmPresenter.set(id: id, type: type)
        }
    }

    func closeCurrentModule() {
        viewController?.closeModule()
    }
}
