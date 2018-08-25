//
//  CastRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol CastRoutingInput {
    func navigateToAboutArtist(withId id: Int)
}

final class CastRouting: CastRoutingInput {

    weak var viewController: CastViewController!

    func navigateToAboutArtist(withId id: Int) {
        viewController.openModule(withName: "AboutArtist") { moduleInput in
            guard let aboutArtistPresenter = moduleInput as? AboutArtistPresenter else {
                fatalError("Could not cast this moduleInput to AboutArtistPresenter")
            }
            aboutArtistPresenter.set(id: id)
        }
    }
}
