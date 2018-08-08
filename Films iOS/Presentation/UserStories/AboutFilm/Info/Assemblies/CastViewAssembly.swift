//
//  CastViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class CastViewAssembly: Assembly {

    lazy var detailsFilmPresenterAssembly: DetailsFilmPresenterAssembly = DetailsFilmPresenterAssembly.instance()

    lazy var castDisplayManagerAssembly: CastDisplayManagerAssembly = CastDisplayManagerAssembly.instance()

    func inject(into mvc: CastViewController) {
        defineInjection(into: mvc) {
            $0.detailsFilmPresenter = self.detailsFilmPresenterAssembly.detailsFilmPresenter
            $0.castDisplayManager = self.castDisplayManagerAssembly.castDisplayManager
            return $0
        }
    }
}
