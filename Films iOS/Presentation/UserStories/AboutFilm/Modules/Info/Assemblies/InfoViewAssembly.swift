//
//  InfoViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class InfoViewAssembly: Assembly {

    lazy var detailsFilmPresenterAssembly = DetailsFilmPresenterAssembly.instance()

    lazy var infoFilmDisplayManagerAssembly = InfoFilmDisplayManagerAssembly.instance()

    lazy var moviesRotingAssembly = InfoMoviesRoutingAssembly.instance()

    func inject(into mvc: InfoFilmViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.detailsFilmPresenterAssembly.detailsFilmPresenter
            $0.router = self.moviesRotingAssembly.infoMoviesRouting
            $0.infoFilmDisplayManager = self.infoFilmDisplayManagerAssembly.infoFilmDisplayManager
            return $0
        }
    }
}
