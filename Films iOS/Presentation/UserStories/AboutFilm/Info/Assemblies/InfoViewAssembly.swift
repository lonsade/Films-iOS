//
//  InfoViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class InfoViewAssembly: Assembly {

    lazy var detailsFilmPresenterAssembly: DetailsFilmPresenterAssembly = DetailsFilmPresenterAssembly.instance()

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = DetailsFilmDataSourceAssembly.instance()

    func inject(into mvc: InfoFilmViewController) {
        defineInjection(into: mvc) {
            $0.detailsFilmDataSource = self.detailsFilmDataSourceAssembly.detailsFilmDataSource
            $0.detailsFilmPresenter = self.detailsFilmPresenterAssembly.detailsFilmPresenter
            return $0
        }
    }
}
