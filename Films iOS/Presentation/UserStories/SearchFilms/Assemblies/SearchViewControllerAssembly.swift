//
//  SearchViewControllerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchViewControllerAssembly: Assembly {

    lazy var presenterAssembly = SearchFilmsPresenterAssembly.instance()

    lazy var displayManagerAssembly = SearchFilmsDisplayManagerAssembly.instance()

    func inject(into mvc: SearchViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.presenterAssembly.searchFilmsPresenter
            $0.displayManager = self.displayManagerAssembly.searchFilmsDisplayManager
            return $0
        }
    }

}
