//
//  AboutFilmPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 14.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class AboutFilmPresenterAssembly: Assembly {

    var aboutFilmPresenter: AboutFilmInput {
        return define(scope: .lazySingleton, init: AboutFilmPresenter())
    }

}
