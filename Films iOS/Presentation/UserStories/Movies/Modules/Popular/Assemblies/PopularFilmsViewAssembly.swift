//
//  PopularFilmsViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class PopularFilmsViewAssembly: Assembly {

    lazy var filmCollectionDisplayManager: PopularFilmsDisplayManagerAssembly = PopularFilmsDisplayManagerAssembly.instance()

    lazy var popularFilmsPresenterAssembly: PopularFilmsPresenterAssembly = PopularFilmsPresenterAssembly.instance()

    lazy var moviesRoutingAssembly = MoviesRotingAssembly.instance()

    func inject(into pvc: PopularFilmsViewController) {
        defineInjection(into: pvc) {
            $0.filmCollectionDisplayManager = self.filmCollectionDisplayManager.popularFilmsDisplayManager
            $0.presenter = self.popularFilmsPresenterAssembly.popularFilmsPresenter
            $0.router = self.moviesRoutingAssembly.moviesRoting
            $0.moduleInput = self.popularFilmsPresenterAssembly.popularFilmsPresenter
            $0.dataSource = self.popularFilmsPresenterAssembly.popularFilmsDSAssembly.popularFilmsDS
            return $0
        }
    }
}
