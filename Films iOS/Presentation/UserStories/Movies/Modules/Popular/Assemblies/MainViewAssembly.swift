//
//  MainViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class MainViewAssembly: Assembly {

    lazy var tabDisplayManager: TabDisplayManagerAssembly = TabDisplayManagerAssembly.instance()

    lazy var tabNamesPresenterAssembly: TabNamesPresenterAssembly = TabNamesPresenterAssembly.instance()

    func inject(into mvc: MainViewController) {
        defineInjection(into: mvc) {
            $0.tabDisplayManager = self.tabDisplayManager.tabDisplayManager
            $0.tabNamesPresenter = self.tabNamesPresenterAssembly.tabNamesPresenter
            return $0
        }
    }
}
