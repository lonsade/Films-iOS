//
//  AboutFilmContainerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 14.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class AboutFilmContainerAssembly: Assembly {

    var aboutFilmPresenter: AboutFilmInput {
        return define(scope: .lazySingleton, init: AboutFilmPresenter())
    }

    func inject(into mvc: AboutFilmViewController) {
        defineInjection(into: mvc) {
            $0.moduleInput = self.aboutFilmPresenter
            return $0
        }
    }

}
