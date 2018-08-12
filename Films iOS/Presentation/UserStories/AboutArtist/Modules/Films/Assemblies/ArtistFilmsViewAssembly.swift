//
//  ArtistFilmsViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsViewAssembly: Assembly {

    lazy var artistFilmsPresenterAssembly = ArtistFilmsPresenterAssembly.instance()

    lazy var artistFilmsDataSourceAssembly = ArtistFilmsDataSourceAssembly.instance()

    lazy var artistFilmsDMAssembly = ArtistFilmsDisplayManagerAssembly.instance()

    lazy var artistRoutingAssembly = ArtistRoutingAssembly.instance()

    func inject(into mvc: ArtistFilmsViewController) {
        defineInjection(into: mvc) {
            $0.artistFilmsDataSource = self.artistFilmsDataSourceAssembly.artistFilmsDataSource
            $0.artistFilmsDisplayManager = self.artistFilmsDMAssembly.artistFilmsDisplayManager
            $0.artistFilmsPresenter = self.artistFilmsPresenterAssembly.artistFilmsPresenter
            $0.moviesRouting = self.artistRoutingAssembly.artistRouting
            return $0
        }
    }
}
