//
//  AboutArtistPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class AboutArtistPresenterAssembly: Assembly {

    var aboutArtistPresenter: AboutArtistInput {
        return define(scope: .lazySingleton, init: AboutArtistPresenter())
    }

}
