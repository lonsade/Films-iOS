//
//  MoviesContainerRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 27.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol MoviesContainerRoutingInput: BaseRoutingProtocol {
    func navigateToSearch()
}

final class MoviesContainerRouting: MoviesContainerRoutingInput {
    func closeCurrentModule() {
        viewController?.closeModule()
    }

    var viewController: BaseHandlerController?

    func navigateToSearch() {
        viewController?.openModule(withName: L10n.Module.search)
    }
}
