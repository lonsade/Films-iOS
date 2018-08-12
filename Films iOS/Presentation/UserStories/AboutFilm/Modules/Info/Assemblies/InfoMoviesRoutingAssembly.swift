//
//  InfoMoviesRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class InfoMoviesRoutingAssembly: Assembly {

    lazy var filmCollectionDM = InfoFilmDisplayManagerAssembly.instance()

    lazy var filmCoolectionDS = DetailsFilmDataSourceAssembly.instance()

    var infoMoviesRouting: BaseMoviesRoutingProtocol & BaseMoviesRoutingOutput {
        return define(scope: .lazySingleton, init:
            BaseMoviesRouting(
                filmCollectionDisplayManager: self.filmCollectionDM.similarDisplayManager,
                filmCollectionDataSource: self.filmCoolectionDS.similarFilmDataSource
            )
        )
    }

}
