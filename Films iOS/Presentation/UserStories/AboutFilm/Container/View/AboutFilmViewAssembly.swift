//
//  AboutFilmViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 14.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class AboutFilmViewAssembly: Assembly {

    lazy var presenterAssembly = AboutFilmPresenterAssembly.instance()

    func inject(into mvc: AboutFilmViewController) {
        defineInjection(into: mvc) {
            $0.moduleInput = self.presenterAssembly.aboutFilmPresenter
            return $0
        }
    }

}
