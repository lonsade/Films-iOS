//
//  ArtistRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class ArtistRoutingAssembly: Assembly {

    lazy var filmCollectionDM = ArtistFilmsDisplayManagerAssembly.instance()

    lazy var filmCoolectionDS = ArtistFilmsDataSourceAssembly.instance()

    var artistRouting: BaseMoviesRoutingProtocol & BaseMoviesRoutingOutput {
        return define(scope: .lazySingleton, init:
            BaseMoviesRouting(
                filmCollectionDisplayManager: self.filmCollectionDM.artistFilmsDisplayManager,
                filmCollectionDataSource: self.filmCoolectionDS.artistFilmsDataSource
            )
        )
    }

}
