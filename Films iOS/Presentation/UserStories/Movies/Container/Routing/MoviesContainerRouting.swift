//
//  MoviesContainerRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 27.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol MoviesContainerRoutingInput: BaseRoutingProtocol {
    func navigateToSearch(withType type: Int)
}

final class MoviesContainerRouting: MoviesContainerRoutingInput {
    func closeCurrentModule() {
        viewController?.closeModule()
    }

    weak var viewController: BaseHandlerController?

    func navigateToSearch(withType type: Int) {

        viewController?.openModule(withName: L10n.Module.search) { moduleInput in
            guard let searchFilmsPresenter = moduleInput as? SearchFilmsPresenterInput else {
                return assertionFailure("Could not cast this moduleInput to \(String(describing: SearchFilmsPresenterInput.self)).")
            }
            searchFilmsPresenter.set(type: type)
        }
    }
}
