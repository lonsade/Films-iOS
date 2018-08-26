//
//  CastRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol CastRoutingInput: BaseRoutingProtocol {
    func navigateToAboutArtist(withId id: Int)
}

final class CastRouting: CastRoutingInput {

    weak var viewController: BaseHandlerController?

    func closeCurrentModule() {
        viewController?.closeModule()
    }

    func navigateToAboutArtist(withId id: Int) {
        viewController?.openModule(withName: "AboutArtist") { moduleInput in
            guard let aboutArtistPresenter = moduleInput as? AboutArtistPresenter else {
                 return assertionFailure("Could not cast this moduleInput to \(String(describing: AboutArtistPresenter.self)).")
            }
            aboutArtistPresenter.set(id: id)
        }
    }
}
