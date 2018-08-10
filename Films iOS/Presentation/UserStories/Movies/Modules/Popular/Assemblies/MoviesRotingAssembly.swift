//
//  MoviesRotingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class MoviesRotingAssembly: Assembly {

    lazy var filmCollectionDM = PopularFilmsDisplayManagerAssembly.instance()

    lazy var filmCoolectionDS = PopularFilmsDSAssembly.instance()

    var moviesRoting: MoviesRouting {
        return define(scope: .lazySingleton, init:
            MoviesRouting(
                filmCollectionDisplayManager: self.filmCollectionDM.popularFilmsDisplayManager,
                filmCollectionDataSource: self.filmCoolectionDS.popularFilmsDS
            )
        )
    }

}
