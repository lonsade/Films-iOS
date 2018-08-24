//
//  AboutArtistViewControllerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class AboutArtistViewControllerAssembly: Assembly {

    lazy var presenterAssembly = AboutArtistPresenterAssembly.instance()

    func inject(into mvc: AboutArtistViewController) {
        defineInjection(into: mvc) {
            $0.moduleInput = self.presenterAssembly.aboutArtistPresenter
            return $0
        }
    }

}
