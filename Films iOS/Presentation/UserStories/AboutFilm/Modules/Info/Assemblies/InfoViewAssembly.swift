//
//  InfoViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class InfoViewAssembly: Assembly {

    lazy var detailsFilmPresenterAssembly: DetailsFilmPresenterAssembly = DetailsFilmPresenterAssembly.instance()

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = DetailsFilmDataSourceAssembly.instance()

    lazy var infoFilmDisplayManagerAssembly: InfoFilmDisplayManagerAssembly = InfoFilmDisplayManagerAssembly.instance()

    lazy var moviesRotingAssembly = InfoMoviesRoutingAssembly.instance()

    func inject(into mvc: InfoFilmViewController) {
        defineInjection(into: mvc) {
            $0.detailsFilmDataSource = self.detailsFilmDataSourceAssembly.detailsFilmDataSource
            $0.detailsFilmPresenter = self.detailsFilmPresenterAssembly.detailsFilmPresenter
            $0.galleryDisplayManager = self.infoFilmDisplayManagerAssembly.galleryDisplayManager
            $0.similarDisplayManager = self.infoFilmDisplayManagerAssembly.similarDisplayManager
            $0.movieRouting = self.moviesRotingAssembly.infoMoviesRouting
            return $0
        }
    }
}
