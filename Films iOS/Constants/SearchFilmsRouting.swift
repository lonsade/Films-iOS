//
//  SearchFilmsRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 27.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol SearchFilmsRoutingInput: BaseRoutingProtocol {
    func navigateToAboutFilm(withId id: Int)
}

final class SearchFilmsRouting: SearchFilmsRoutingInput {

    weak var viewController: BaseHandlerController?

    func closeCurrentModule() {
        viewController?.closeModule()
    }

    func navigateToAboutFilm(withId id: Int) {
        viewController?.openModule(withName: L10n.Module.aboutFilm) { moduleInput in
            guard let aboutFilmPresenter = moduleInput as? AboutFilmInput else {
                return assertionFailure("Could not cast this moduleInput to \(String(describing: AboutFilmInput.self)).")
            }
            aboutFilmPresenter.set(id: id)
        }
    }

}
